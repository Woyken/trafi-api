import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: InterfaceC10942y9.java — User/Auth API
// Source: egf.java — Server time
@tag("Auth")
@route("/")
interface Auth {
  // Source: InterfaceC10942y9.java — @xra("v2/users/signin/token")
  @doc("Sign in with Firebase token")
  @route("v2/users/signin/token")
  @post
  signIn(@body body: Trafi.Models.AuthenticateRequest):
    | Trafi.Models.AuthenticateResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: egf.java — @d06("v1/app/server/time")
  @doc("Get current server time in milliseconds")
  @route("v1/app/server/time")
  @get
  getServerTime(
  ): Trafi.Models.ServerTime | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;
}
