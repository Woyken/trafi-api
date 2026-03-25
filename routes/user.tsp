import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: InterfaceC10942y9.java — User/Auth API
// Source: fec.java — Account API
// Source: meb.java — Payments API
// Source: kja.java — Provider API
@tag("Users")
@route("/")
interface Users {
  // Source: InterfaceC10942y9.java — @d06("v1/users/profile")
  @doc("Get the authenticated user's profile")
  @route("v1/users/profile")
  @get
  getProfile(
  ): Trafi.Models.User | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @xra("v1/users/profile/update")
  @doc("Update the user's profile information")
  @route("v1/users/profile/update")
  @post
  updateProfile(@body body: Trafi.Models.Profile):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @d06("/v2/providers")
  @doc("Get available transport providers")
  @route("v2/providers")
  @get
  getProviders(
  ): Trafi.Models.Provider[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @d06("/v1/users/can-delete")
  @doc("Check if the user account can be deleted")
  @route("v1/users/can-delete")
  @get
  canDeleteUser(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @ae6("/v1/users/delete")
  @doc("Delete the user account")
  @route("v1/users/delete")
  @delete
  deleteUser(@body body: {}):
    | Trafi.Models.EmptySuccessResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @yra("v1/users/settings")
  @doc("Update user settings")
  @route("v1/users/settings")
  @put
  updateSettings(@body body: {}):
    | Trafi.Models.EmptySuccessResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @xra("v1/users/verifyphone")
  @doc("Submit phone number verification")
  @route("v1/users/verifyphone")
  @post
  verifyPhone(@header("X-Captcha-Token") captchaToken: string, @body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @xra("v2/users/provider/requirements")
  @doc("Get requirements for connecting to a provider")
  @route("v2/users/provider/requirements")
  @post
  getProviderRequirements(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @d06("v1/app/features/{featureId}")
  @doc("Get the status of a feature flag")
  @route("v1/app/features/{featureId}")
  @get
  getFeatureStatus(@path featureId: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @xra("/v1/users/check-device") — verified POST not GET
  @doc("Check if a device is registered for a user")
  @route("v1/users/check-device")
  @post
  checkDevice(@query deviceId: string, @header("X-User-Id") userId: string):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: kja.java — @xra("v1/users/provider/connect")
  @doc("Connect user account to a transport provider")
  @route("v1/users/provider/connect")
  @post
  connectProvider(@body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: kja.java — @xra("v1/users/provider/register")
  @doc("Register user with a transport provider")
  @route("v1/users/provider/register")
  @post
  registerProvider(@body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: fec.java — @d06("v1/users/providers/requirements/groups")
  @doc("Get grouped provider connection requirements")
  @route("v1/users/providers/requirements/groups")
  @get
  getProviderRequirementsGroups(
  ): {}[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: fec.java — @xra("v1/users/provider/disconnect")
  @doc("Disconnect user from a transport provider")
  @route("v1/users/provider/disconnect")
  @post
  disconnectProvider(@body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: meb.java — @xra("v1/users/payment/add")
  @doc("Add a payment method")
  @route("v1/users/payment/add")
  @post
  addPaymentMethod(@body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: meb.java — @xra("v1/users/payment/remove")
  @doc("Remove a payment method")
  @route("v1/users/payment/remove")
  @post
  removePaymentMethod(@body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: meb.java — @xra("v1/users/payment/external/add")
  @doc("Initiate adding an external payment method")
  @route("v1/users/payment/external/add")
  @post
  initiateAddPaymentMethod(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: meb.java — @xra("v3/users/payment/default")
  @doc("Set the default payment method")
  @route("v3/users/payment/default")
  @post
  updateDefaultPaymentMethod(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC5601ge.java — @d06("v1/home/activation/value")
  @doc("Get account activation status value")
  @route("v1/home/activation/value")
  @get
  getAccountActivationValue(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java m86482l — @xra("v1/users/verification")
  @doc("Submit identity verification documents")
  @route("v1/users/verification")
  @post
  submitVerification(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;
}
