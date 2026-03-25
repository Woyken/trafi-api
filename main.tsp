import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/openapi3";

// ─── Models ───
import "./models/enums.tsp";
import "./models/common.tsp";
import "./models/auth.tsp";
import "./models/user.tsp";
import "./models/tickets.tsp";
import "./models/bookings.tsp";
import "./models/passes.tsp";
import "./models/transit.tsp";
import "./models/routing.tsp";
import "./models/ondemand.tsp";
import "./models/promotions.tsp";
import "./models/notifications.tsp";

// ─── Routes ───
import "./routes/auth.tsp";
import "./routes/tickets.tsp";
import "./routes/bookings.tsp";
import "./routes/passes.tsp";
import "./routes/transit.tsp";
import "./routes/routing.tsp";
import "./routes/ondemand.tsp";
import "./routes/user.tsp";
import "./routes/config.tsp";
import "./routes/promotions.tsp";
import "./routes/notifications.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

/**
 * Trafi Whitelabel App API
 *
 * Reverse-engineered from the decompiled Android app (com.trafi.android.tr)
 *
 * ## Authentication
 *
 * The API uses Firebase Authentication with the Firebase `idToken` as the Bearer token.
 *
 * ### 1. Firebase Login
 * ```
 * POST https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyDW6rTWvRwUNIdoOCthRNlAZKAbLPB3oiM
 * Headers: x-android-package: com.trafi.android.tr
 *          x-android-cert: 38D25C57CE498395B32DC62ED95CAE9E203D948A
 * Body: { "email": "...", "password": "...", "returnSecureToken": true, "clientType": "CLIENT_TYPE_ANDROID" }
 * Response: { "idToken": "...", "refreshToken": "...", "expiresIn": "3600" }
 * ```
 *
 * ### 2. Trafi Signin (optional)
 * ```
 * POST /v2/users/signin/token
 * Authorization: Bearer <idToken>
 * Body: { "token": "<idToken>" }
 * Response: { "user": { ... } }
 * ```
 *
 * ### 3. Use idToken as Bearer for all API calls
 * ```
 * Authorization: Bearer <Firebase idToken>
 * ```
 *
 * ### 4. Token Refresh (when expired, default lifetime 1h)
 * ```
 * POST https://securetoken.googleapis.com/v1/token?key=AIzaSyDW6rTWvRwUNIdoOCthRNlAZKAbLPB3oiM
 * Body: { "grantType": "refresh_token", "refreshToken": "..." }
 * Response: { "id_token": "...", "refresh_token": "...", "expires_in": "3600" }
 * ```
 *
 * ### Required Headers
 * | Header | Value | Required | Notes |
 * |--------|-------|----------|-------|
 * | Authorization | Bearer \<Firebase idToken\> | Yes | |
 * | x-device-id | Persistent UUID | Yes (400 without) | **Determines ticket visibility** |
 * | x-install-id | UUID | Yes | Does NOT affect ticket binding |
 * | x-region-id | e.g. "lithuania" | Recommended | |
 * | x-os | "android" | Recommended | |
 * | x-app-version | e.g. "11461481" | Recommended | |
 *
 * ### ⚠️ x-device-id and Ticket Binding
 *
 * Active tickets are **bound to the `x-device-id` header**. When a ticket is activated
 * (via m.ticket, Trafi app, or `POST /v2/tickets/activate`), the first `x-device-id`
 * that queries `/v2/tickets` or `/v2/bookings` **claims ownership** of the active ticket.
 *
 * **Verified behavior:**
 * - Same `x-device-id` → sees ACTIVE ticket ✓
 * - Different `x-device-id` → does NOT see ACTIVE ticket ✗
 *
 * The `x-device-id` must be **persisted across sessions**. Generating a new UUID each
 * time will cause loss of visibility to previously claimed active tickets.
 * On Android, this value comes from `Settings.Secure.ANDROID_ID` (see `je4.java`),
 * injected by the HTTP interceptor `fe4.java`.
 *
 * See AUTH.md for the full authentication documentation.
 */
@service(#{ title: "Trafi Whitelabel App API" })
@info(#{
  version: "1.0.0",
  contact: #{ name: "Reverse-engineered API", url: "https://github.com" },
})
@server("https://whitelabel-app-api-wl.vilkas.trafi.com", "Production")
namespace Trafi;
