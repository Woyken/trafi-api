import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/AuthenticateRequest.java — field "token" @yi7
@example(#{
  token: "eyJhbGciOiJSUzI1NiIs..."
})
@doc("Request to authenticate with the Trafi API using a Firebase token")
model AuthenticateRequest {
  @doc("Firebase idToken obtained from Firebase Authentication")
  token: string;
}

// Source: com/trafi/core/model/AuthenticateResponse.java — field "user" @yi7
@doc("Response from authentication containing the user profile")
model AuthenticateResponse {
  user: User;
}

// Source: com/trafi/core/model/SignInResponse.java — fields "user", "authData" @yi7
@doc("Full sign-in response with user profile and auth tokens")
model SignInResponse {
  user: User;
  authData: AuthData;
}

// Source: com/trafi/core/model/AuthData.java
@doc("Authentication token data")
model AuthData {
  @doc("OAuth access token")
  accessToken: string;
  @doc("Token used to obtain a new access token")
  refreshToken: string;
  @doc("ISO 8601 timestamp when the access token expires")
  accessTokenExpiresAt: string;
  refreshTokenExpiresAt?: string;
}
