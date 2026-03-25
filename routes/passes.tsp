import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: nk9.java — Passes API (7 endpoints)
@tag("Passes")
@route("/")
interface Passes {
  // Source: nk9.java — @d06("/v1/app/passes/config")
  @doc("Get passes feature configuration")
  @route("v1/app/passes/config")
  @get
  getConfig(
  ): Trafi.Models.PassesConfig | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: nk9.java — @d06("/v1/app/passes/user/active")
  @doc("Get user's currently active passes")
  @route("v1/app/passes/user/active")
  @get
  getUserActivePasses(
  ): Trafi.Models.GetUserActivePassesResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: nk9.java — @d06("/v1/app/passes/{passId}")
  @doc("Get details of a specific pass")
  @route("v1/app/passes/{passId}")
  @get
  getPass(@path passId: string):
    | Trafi.Models.Pass
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: nk9.java — @d06("/v1/app/passes/products")
  @doc("Get available pass products")
  @route("v1/app/passes/products")
  @get
  getProducts(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: nk9.java — @xra("/v1/app/passes/buy")
  @doc("Purchase a pass")
  @route("v1/app/passes/buy")
  @post
  buyPass(@body body: Trafi.Models.BuyPassRequest):
    | Trafi.Models.BuyPassResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: nk9.java — @xra("/v1/app/passes/confirm")
  @doc("Confirm a pending pass purchase after payment challenge")
  @route("v1/app/passes/confirm")
  @post
  confirmPass(@body body: Trafi.Models.ConfirmPassRequest):
    | Trafi.Models.BuyPassResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: nk9.java — @xra("/v1/app/passes/cancel") — verified POST not DELETE
  @doc("Cancel a pass purchase")
  @route("v1/app/passes/cancel")
  @post
  cancelPass(@body body: Trafi.Models.CancelPassRequest):
    | Trafi.Models.EmptySuccessResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;
}
