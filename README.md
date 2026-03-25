# Trafi Whitelabel App API — TypeSpec Documentation

> **⚠️ Educational Purpose Only**
>
> This project is a reverse-engineered API specification created strictly for educational and research purposes.
> The API was reverse-engineered from the decompiled Android application **com.trafi.android.tr** (Trafi Lithuania).
> This project is not affiliated with, endorsed by, or associated with Trafi / Trafi GmbH in any way.

## What is this?

A [TypeSpec](https://typespec.io/) project documenting the Trafi Whitelabel App API — the backend powering the Trafi public transit app in Lithuania. The spec covers **147 endpoints** across 11 domains and **230+ data models**.

## How it was built

1. **Decompiled** the Android APK using JADX (`com.trafi.android.tr`)
2. **Mapped** obfuscated Retrofit annotations to HTTP methods (`@d06` → GET, `@xra` → POST, etc.)
3. **Extracted** models from Moshi `@yi7` (JSON) annotations in 714 model classes
4. **Validated** through multiple automated passes — 147 Java endpoints = 147 TypeSpec endpoints, 0 missing, 0 phantom

## API Domains

| Tag | Description | Endpoints |
|-----|-------------|-----------|
| Auth | Firebase authentication & sign-in | 2 |
| Bookings | Active bookings aggregation | 1 |
| Tickets | Ticket purchase, activation & management | 10 |
| Passes | Mobility passes | 7 |
| Transit | Stops, schedules, departures & vehicles | 16 |
| Routing | Route search & active trip navigation | 6 |
| OnDemand | Sharing, rental & ride-hailing | 34 |
| Users | Profile, payments & provider accounts | 20 |
| Config | App config, feedback, legal, location & history | 36 |
| Promotions | Promotions & referrals | 10 |
| Notifications | Push notifications | 3 |

## Building

```bash
# Install dependencies
npm install

# Compile TypeSpec → OpenAPI 3.0
npx tsp compile .

# Output: tsp-output/@typespec/openapi3/openapi.yaml
```

## Project structure

```
typespec/
├── main.tsp                 # Entry point, service metadata, auth docs
├── tspconfig.yaml           # Compiler config (emits OpenAPI 3.0)
├── AUTH.md                  # Detailed authentication documentation
├── models/                  # 12 model files (230+ models, 18 enums)
│   ├── enums.tsp            # All enum types
│   ├── common.tsp           # Shared models (errors, providers, locations)
│   ├── auth.tsp             # Authentication models
│   ├── tickets.tsp          # Ticket models (33-field Ticket, products, etc.)
│   ├── bookings.tsp         # Booking aggregation models
│   ├── user.tsp             # User profile & payment models
│   ├── passes.tsp           # Mobility pass models
│   ├── transit.tsp          # Transit stop, schedule & vehicle models
│   ├── routing.tsp          # Route search & navigation models
│   ├── ondemand.tsp         # Sharing, rental & ride-hailing models
│   ├── promotions.tsp       # Promotion & referral models
│   └── notifications.tsp    # Push notification models
├── routes/                  # 11 route files (147 endpoints)
│   ├── auth.tsp
│   ├── tickets.tsp
│   ├── bookings.tsp
│   ├── passes.tsp
│   ├── transit.tsp
│   ├── routing.tsp
│   ├── ondemand.tsp
│   ├── user.tsp
│   ├── config.tsp
│   ├── promotions.tsp
│   └── notifications.tsp
└── tsp-output/              # Generated output
    └── @typespec/openapi3/
        └── openapi.yaml     # Generated OpenAPI 3.0 spec (~8300 lines)
```

## Key discoveries

- **Authentication**: Uses Firebase Authentication — the Firebase `idToken` is the Bearer token for all API calls (not a separate Trafi token)
- **Ticket binding**: Active tickets are bound to the `x-device-id` header. The first device ID that queries tickets "claims" ownership — different device IDs cannot see the same active ticket
- **Polling only**: The app uses polling (15s intervals via Firebase Remote Config) — no WebSocket, SSE, or gRPC push channels exist
- **Cross-app compatibility**: Tickets activated in the m.ticket app are visible through the Trafi API (shared MTIS backend)

See [AUTH.md](./AUTH.md) for the full authentication flow documentation.

## Disclaimer

This reverse engineering was performed for personal educational purposes to understand how public transit APIs work. No proprietary business logic, encryption keys, or paid content was extracted. The Firebase API key used is a public client-side key embedded in the published APK.
