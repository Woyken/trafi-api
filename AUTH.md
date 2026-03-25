# Trafi API — Authentication Documentation

> Reverse-engineered from the decompiled Android app (`com.trafi.android.tr`).

## Overview

The Trafi API uses a **two-layer authentication** model:

1. **Firebase Authentication** — Handles user login, password verification, and token issuance/refresh
2. **Trafi API Signin** — Registers the Firebase-authenticated user with the Trafi backend

The **Firebase `idToken`** is used directly as the `Bearer` token for all Trafi API calls. There is no separate Trafi-specific token exchange.

---

## Step-by-Step Authentication Flow

### Step 1: Firebase Login

Authenticate the user with Firebase Identity Toolkit using email/password credentials.

**Request:**

```
POST https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyDW6rTWvRwUNIdoOCthRNlAZKAbLPB3oiM
```

**Headers:**

| Header | Value | Required |
|--------|-------|----------|
| `x-android-package` | `com.trafi.android.tr` | Yes |
| `x-android-cert` | `38D25C57CE498395B32DC62ED95CAE9E203D948A` | Yes |
| `Content-Type` | `application/json` | Yes |

**Body:**

```json
{
  "email": "user@example.com",
  "password": "user-password",
  "returnSecureToken": true,
  "clientType": "CLIENT_TYPE_ANDROID"
}
```

**Response (200 OK):**

```json
{
  "idToken": "eyJhbGciOiJSUzI1NiIs...",
  "refreshToken": "AMf-vBx...",
  "expiresIn": "3600",
  "localId": "abc123...",
  "email": "user@example.com",
  "registered": true
}
```

| Field | Description |
|-------|-------------|
| `idToken` | JWT token — **this is the Bearer token for all Trafi API calls** |
| `refreshToken` | Long-lived token used to obtain new `idToken` when expired |
| `expiresIn` | Token lifetime in seconds (default: `"3600"` = 1 hour) |
| `localId` | Firebase user ID |

**Source:** `trafi_client.py` lines 126–151, Firebase Identity Toolkit API

---

### Step 2: Store Tokens & Calculate Expiry

After a successful Firebase login:

1. Store the `idToken` as the active Bearer token
2. Store the `refreshToken` for later refresh
3. Calculate token expiry: `expiry = now + int(expiresIn)` seconds
4. Apply a **5-minute buffer** when checking expiry (refresh early to avoid 401s)

```python
# Pseudocode
token_expiry = time.time() + int(response["expiresIn"])

def is_expired():
    return time.time() >= (token_expiry - 300)  # 5-min buffer
```

**Source:** `trafi_client.py` line 121 (5-minute buffer), interceptor `yh0.java` lines 54–56 (synchronized refresh)

---

### Step 3: Trafi API Signin (Optional but Recommended)

Register the authenticated user with the Trafi backend. This returns the user profile and ensures the backend recognizes this session.

**Request:**

```
POST https://whitelabel-app-api-wl.vilkas.trafi.com/v2/users/signin/token
```

**Headers:** (see [Required Headers](#required-headers-for-all-api-calls) below)

**Body:**

```json
{
  "token": "<Firebase idToken>"
}
```

**Response (200 OK):**

```json
{
  "user": {
    "id": "1886b1b0-a23b-11ed-9abc-8bc438e180ef",
    "profile": {
      "firstName": "...",
      "lastName": "...",
      "email": "..."
    },
    "paymentMethods": [...],
    "providerAccounts": [...],
    ...
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| `user` | `User` | Full user profile object (14 fields — see User model) |

> **Note:** The response contains only `user`. There is **no `authData` or access token** returned — the Firebase `idToken` remains the sole API token.

**Source:** `InterfaceC10942y9.java` line 67–69 (`@xra`), `AuthenticateRequest.java` (field: `token`), `AuthenticateResponse.java` (field: `user`)

---

### Step 4: Make Authenticated API Calls

Use the Firebase `idToken` as Bearer token for all subsequent Trafi API requests.

```
GET https://whitelabel-app-api-wl.vilkas.trafi.com/v2/tickets?includeExpiredTickets=false
Authorization: Bearer eyJhbGciOiJSUzI1NiIs...
x-device-id: f68fd21b-043b-58dd-0000-000000000000
x-install-id: a1b2c3d4-e5f6-7890-abcd-ef1234567890
x-region-id: lithuania
x-os: android
x-app-version: 11461481
```

---

### Step 5: Token Refresh (When Expired)

When the `idToken` expires (or is about to expire within 5 minutes), refresh it using the stored `refreshToken`.

**Request:**

```
POST https://securetoken.googleapis.com/v1/token?key=AIzaSyDW6rTWvRwUNIdoOCthRNlAZKAbLPB3oiM
```

**Headers:**

| Header | Value | Required |
|--------|-------|----------|
| `x-android-package` | `com.trafi.android.tr` | Yes |
| `x-android-cert` | `38D25C57CE498395B32DC62ED95CAE9E203D948A` | Yes |
| `Content-Type` | `application/json` | Yes |

**Body:**

```json
{
  "grantType": "refresh_token",
  "refreshToken": "<stored refreshToken>"
}
```

**Response (200 OK):**

```json
{
  "id_token": "eyJhbGciOiJSUzI1NiIs...",
  "refresh_token": "AMf-vBx...",
  "expires_in": "3600",
  "token_type": "Bearer",
  "user_id": "abc123..."
}
```

> **Note:** Response field names use `snake_case` (`id_token`, `refresh_token`, `expires_in`), unlike the login response which uses `camelCase`.

After refresh:
1. Replace stored `idToken` with new `id_token`
2. Replace stored `refreshToken` with new `refresh_token`
3. Recalculate expiry: `expiry = now + int(expires_in)`

**Source:** `trafi_client.py` lines 153–182, `securetoken.googleapis.com` API

---

### Step 6: Handle 401 Responses

The app's OkHttp interceptor (`yh0.java`) handles 401 responses automatically:

1. Receive 401 response from Trafi API
2. Parse error body for error code
3. If error code is `"users:refresh_token_invalid_or_expired"`:
   - Trigger synchronized token refresh (prevents thundering herd)
   - Wait up to **10 seconds** for refresh to complete
   - Retry the original request with the new token
4. If refresh fails entirely and credentials are stored:
   - **Fall back to full re-login** (repeat Step 1)

**Source:** `yh0.java` lines 138–195, error code registry `ilb.java`

---

## Required Headers for All API Calls

Every request to the Trafi API must include these headers. They are injected by interceptors `eg6.java` and `fe4.java`.

| Header | Value | Required | Source |
|--------|-------|----------|--------|
| `Authorization` | `Bearer <Firebase idToken>` | **Yes** | `zh0.java` line 10 |
| `x-device-id` | UUID (persistent per device) | **Yes** | `fe4.java` line 25 — **400 error without this** |
| `x-install-id` | UUID (persistent per installation) | **Yes** | `eg6.java` line 77 |
| `x-region-id` | Region identifier (e.g. `"lithuania"`) | Recommended | `eg6.java` line 89 |
| `x-os` | `"android"` | Recommended | `eg6.java` line 77 |
| `x-app-version` | App version code (e.g. `"11461481"`) | Recommended | `eg6.java` line 77 |
| `Accept-Language` | Locale code (e.g. `"en"`) | Optional | `eg6.java` line 72 |
| `x-user-id` | User UUID (after login) | Optional | `eg6.java` line 85 |
| `x-city-id` | City identifier | Optional | `eg6.java` line 93 |
| `x-ab-flags` | A/B test flags from Remote Config | Optional | `eg6.java` line 77 |

---

## ⚠️ x-device-id and Ticket Binding

Active tickets are **bound to the `x-device-id` header**. This is the most critical implementation detail for any API client that needs to see active tickets.

### How It Works

When a ticket is activated (via m.ticket app, Trafi app, or `POST /v2/tickets/activate`), the **first `x-device-id` that queries** `/v2/tickets` or `/v2/bookings` **claims server-side ownership** of the active ticket. Subsequent requests with a different `x-device-id` will **not** see the active ticket.

### Device id Behavior

| `x-device-id` | Sees ACTIVE ticket? |
|----------------|-----------------|---------------------|
| Same as claimer | ✅ Yes |
| Different | ❌ No |

### Implementation Requirements

1. **Persist `x-device-id`** across application restarts. Generating a new UUID each time will cause loss of visibility to previously claimed active tickets.
2. On Android, the value comes from `Settings.Secure.ANDROID_ID` (see `je4.java`), injected by the HTTP interceptor `fe4.java`.
3. The binding mechanism is **implicit** — there is no explicit "claim" API call. The server tracks which `x-device-id` first fetched an active ticket.
4. The `ActivateTicketRequest` model does **not** include a `deviceId` field — the binding happens via the header, not the request body.

### Cross-App Ticket Sharing

The Trafi and m.ticket apps share the same MTIS ticketing backend. A ticket activated in m.ticket becomes visible to the first Trafi API client (identified by `x-device-id`) that queries it. After that, only that specific `x-device-id` can see the active ticket.

---

## Configuration Values

```
# Firebase
FIREBASE_API_KEY_PROD    = "AIzaSyDW6rTWvRwUNIdoOCthRNlAZKAbLPB3oiM"
FIREBASE_API_KEY_DEV     = "AIzaSyAx5tyo-sOIAUhSlqv6DTdijMGsg-njB54"
FIREBASE_LOGIN_URL       = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword"
FIREBASE_REFRESH_URL     = "https://securetoken.googleapis.com/v1/token"
ANDROID_PACKAGE          = "com.trafi.android.tr"
ANDROID_CERT_HASH        = "38D25C57CE498395B32DC62ED95CAE9E203D948A"

# Trafi API
TRAFI_BASE_URL           = "https://whitelabel-app-api-wl.vilkas.trafi.com"
TRAFI_SIGNIN_ENDPOINT    = "POST /v2/users/signin/token"
TRAFI_SERVER_TIME        = "GET /v1/app/server/time"

# Defaults
TOKEN_EXPIRY_BUFFER_SEC  = 300       # 5 minutes
TOKEN_LIFETIME_SEC       = 3600      # 1 hour (default)
REFRESH_TIMEOUT_SEC      = 10        # Max wait for synchronized refresh
REGION_ID                = "lithuania"
OS_IDENTIFIER            = "android"
```

---

## Sequence Diagram

```
┌────────┐          ┌──────────┐          ┌───────────┐
│ Client │          │ Firebase │          │ Trafi API │
└───┬────┘          └────┬─────┘          └─────┬─────┘
    │                    │                      │
    │  1. verifyPassword │                      │
    │  (email+password)  │                      │
    │───────────────────>│                      │
    │                    │                      │
    │  idToken,          │                      │
    │  refreshToken      │                      │
    │<───────────────────│                      │
    │                    │                      │
    │  2. POST /v2/users/signin/token           │
    │  Authorization: Bearer <idToken>          │
    │  Body: { token: <idToken> }               │
    │──────────────────────────────────────────>│
    │                                           │
    │  { user: { id, profile, ... } }           │
    │<──────────────────────────────────────────│
    │                    │                      │
    │  3. GET /v2/tickets (or any endpoint)     │
    │  Authorization: Bearer <idToken>          │
    │──────────────────────────────────────────>│
    │                    │                      │
    │  { tickets: [...] }                       │
    │<──────────────────────────────────────────│
    │                    │                      │
    │  ── Token expires (after ~55 min) ──      │
    │                    │                      │
    │  4. POST /v1/token │                      │
    │  (refresh_token)   │                      │
    │───────────────────>│                      │
    │                    │                      │
    │  new id_token,     │                      │
    │  new refresh_token │                      │
    │<───────────────────│                      │
    │                    │                      │
    │  5. Resume API calls with new token       │
    │──────────────────────────────────────────>│
    │                    │                      │
```

---

## Models (TypeSpec)

### AuthenticateRequest
```typespec
model AuthenticateRequest {
  token: string;  // Firebase idToken
}
```
**Source:** `AuthenticateRequest.java` — single `@yi7(name = "token")` field

### AuthenticateResponse
```typespec
model AuthenticateResponse {
  user: User;  // Full user profile
}
```
**Source:** `AuthenticateResponse.java` — single `@yi7(name = "user")` field

### ServerTime
```typespec
model ServerTime {
  currentTimeMillis: int64;  // Server timestamp in milliseconds
}
```
**Source:** `ServerTime.java` — single `@yi7(name = "currentTimeMillis")` field

### Legacy Models (Defined but Not Used in Current Flow)

These models exist in the codebase but are **not returned** by the current signin endpoint:

```typespec
model SignInResponse {
  user: User;
  authData: AuthData;
}

model AuthData {
  accessToken: string;
  refreshToken: string;
  accessTokenExpiresAt: string;
  refreshTokenExpiresAt?: string;
}
```

**Source:** `SignInResponse.java`, `AuthData.java` — likely from an older auth flow or alternative provider auth

---

## Important Implementation Notes

1. **Firebase `idToken` IS the API token** — No secondary token exchange occurs. The `idToken` from Firebase login is used directly as `Bearer` token for all Trafi API calls.

2. **`x-device-id` is mandatory** — The API returns HTTP 400 without this header. Any UUID works, but it should be consistent across sessions for ticket visibility (tickets may be device-bound).

3. **Token refresh is proactive** — The app refreshes tokens 5 minutes before expiry, not on 401. The 401 handler is a fallback.

4. **Synchronized refresh** — The interceptor uses a lock to prevent multiple concurrent refresh requests (thundering herd protection with 10s timeout).

5. **No push/SSE/WebSocket** — The app uses **polling only** (15-second intervals configurable via Firebase Remote Config) for real-time updates like active tickets.

6. **Ticket device binding** — Active tickets may only be visible from the device that activated them, identified by `x-device-id` and `x-install-id` headers.
