import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: Various interfaces — Config, Feedback, History, etc.
@tag("Config")
@route("/")
interface Config {
  // Source: InterfaceC10942y9.java — @d06("v1/app/config/support/contacts")
  @doc("Get support contact information")
  @route("v1/app/config/support/contacts")
  @get
  getSupportContacts(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC10942y9.java — @d06("v1/app/config/accessibility")
  @doc("Get accessibility configuration")
  @route("v1/app/config/accessibility")
  @get
  getAccessibilityConfig(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: kj3.java — @d06("v1/countries")
  @doc("Get list of supported countries")
  @route("v1/countries")
  @get
  getCountries(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: d1i.java — @d06("v1/travelpreferences")
  @doc("Get user travel preferences")
  @route("v1/travelpreferences")
  @get
  getTravelPreferences(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: jog.java — @d06("/v1/sustainability/config")
  @doc("Get sustainability configuration")
  @route("v1/sustainability/config")
  @get
  getSustainabilityConfig(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // ─── Feedback ───

  // Source: ed5.java — @d06("/v1/feedback/postride/config")
  @doc("Get post-ride feedback configuration")
  @route("v1/feedback/postride/config")
  @get
  getPostRideFeedbackConfig(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: ed5.java — @d06("/v1/feedback/happiness/config")
  @doc("Get happiness feedback configuration")
  @route("v1/feedback/happiness/config")
  @get
  getHappinessFeedbackConfig(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: ed5.java — @d06("/v1/feedback/nps/config")
  @doc("Get NPS feedback configuration")
  @route("v1/feedback/nps/config")
  @get
  getNpsFeedbackConfig(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: ed5.java — @xra("/v1/feedback/postride/submit")
  @doc("Submit post-ride feedback")
  @route("v1/feedback/postride/submit")
  @post
  submitPostRideFeedback(@body body: {}):
    | void
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ed5.java — @xra("/v1/feedback/nps/submit")
  @doc("Submit NPS feedback score")
  @route("v1/feedback/nps/submit")
  @post
  submitNpsFeedback(@body body: {}):
    | void
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ed5.java — @xra("/v1/feedback/comment/submit")
  @doc("Submit text feedback comment")
  @route("v1/feedback/comment/submit")
  @post
  submitCommentFeedback(@body body: {}):
    | void
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Invoices / History ───

  // Source: lc7.java — @d06("v1/history/invoice/{bookingId}")
  @doc("Get invoices for a booking")
  @route("v1/history/invoice/{bookingId}")
  @get
  getInvoices(@path bookingId: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: lc7.java — @d06("v1/history/invoice/{bookingId}/{invoiceId}")
  @doc("Get download URL for a specific invoice")
  @route("v1/history/invoice/{bookingId}/{invoiceId}")
  @get
  getInvoiceUrl(@path bookingId: string, @path invoiceId: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Legal / Terms (nzg.java) ───

  // Source: nzg.java — @d06("v1/app/legal")
  @doc("Get legal documents and terms")
  @route("v1/app/legal")
  @get
  getLegal(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: nzg.java — @d06("v1/app/legal/term-groups")
  @doc("Get grouped legal terms")
  @route("v1/app/legal/term-groups")
  @get
  getTermGroups(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: nzg.java — @d06("v1/app/terms/changes")
  @doc("Get pending terms changes requiring acceptance")
  @route("v1/app/terms/changes")
  @get
  getTermChanges(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: nzg.java — @xra("v1/users/terms")
  @doc("Accept platform terms of service")
  @route("v1/users/terms")
  @post
  acceptTerms(@body body: {}):
    | Trafi.Models.EmptySuccessResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: nzg.java — @xra("v1/users/provider/terms")
  @doc("Accept a specific provider's terms")
  @route("v1/users/provider/terms")
  @post
  acceptProviderTerms(@body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: nzg.java — @xra("v1/users/providers/terms")
  @doc("Accept multiple providers' terms")
  @route("v1/users/providers/terms")
  @post
  acceptProvidersTerms(@body body: {}):
    | Trafi.Models.User
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Provider Manuals (mla.java) ───

  // Source: mla.java — @d06("v1/app/provider-manuals")
  @doc("Get provider usage manuals and instructions")
  @route("v1/app/provider-manuals")
  @get
  getProviderManuals(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // ─── App Config (q73.java) ───

  // Source: q73.java — @xra("v1/app/config")
  @doc("Get application configuration")
  @route("v1/app/config")
  @post
  getAppConfig(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Routes Feedback (oje.java) ───

  // Source: oje.java — @d06("v1/feedback/routes/config")
  @doc("Get route feedback configuration")
  @route("v1/feedback/routes/config")
  @get
  getRoutesFeedbackConfig(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: oje.java — @xra("v1/feedback/routes/rate")
  @doc("Submit a route rating")
  @route("v1/feedback/routes/rate")
  @post
  submitRoutesFeedbackRate(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: oje.java — @xra("v1/feedback/routes/add-comment")
  @doc("Submit a comment on a route")
  @route("v1/feedback/routes/add-comment")
  @post
  submitRoutesFeedbackComment(@body body: {}):
    | void
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: oje.java — @xra("v1/feedback/routes/add-category")
  @doc("Submit a route feedback category")
  @route("v1/feedback/routes/add-category")
  @post
  submitRoutesFeedbackCategory(@body body: {}):
    | void
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Location / Geocoding (o4e.java, ri0.java) ───

  // Source: o4e.java — @d06("v1/location/reversegeocode")
  @doc("Reverse geocode coordinates to an address")
  @route("v1/location/reversegeocode")
  @get
  reverseGeocode(
    @query lat: float64,
    @query lng: float64,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: ri0.java — @d06("v2/location")
  @doc("Search for locations by query string")
  @route("v2/location")
  @get
  searchLocations(
    @query q: string,
    @query subregionId: string,
    @query lat: float64,
    @query lng: float64,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: ri0.java — @d06("v2/location/id/{locationId}")
  @doc("Get location details by ID")
  @route("v2/location/id/{locationId}")
  @get
  getLocationById(@path locationId: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ri0.java — @d06("v1/location/suggested")
  @doc("Get suggested locations for the user")
  @route("v1/location/suggested")
  @get
  getSuggestedLocations(
  ): Trafi.Models.Location[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // ─── User History (o3i.java) ───

  // Source: o3i.java — @d06("v1/history")
  @doc("Get user trip and purchase history")
  @route("v1/history")
  @get
  getHistory(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // ─── Map Objects (rw8.java) ───

  // Source: rw8.java — @d06("v1/home/map/objects/static")
  @doc("Get static map overlay objects")
  @route("v1/home/map/objects/static")
  @get
  getStaticMapObjects(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: rw8.java — @xra("v1/home/map/objects")
  @doc("Get dynamic map objects for the current viewport")
  @route("v1/home/map/objects")
  @post
  getMapObjects(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Mobility Budgets (nc9.java) ───

  // Source: nc9.java — @d06("v1/mobility-budgets/{code}/requirements")
  @doc("Get requirements for a mobility budget invitation")
  @route("v1/mobility-budgets/{code}/requirements")
  @get
  getMobilityBudgetRequirements(@path code: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: nc9.java — @d06("/v1/mobility-budgets/{code}")
  @doc("Get mobility budget invitation details")
  @route("v1/mobility-budgets/{code}")
  @get
  getMobilityBudgetInvitation(@path code: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: nc9.java — @xra("v1/mobility-budgets/accept-invitation")
  @doc("Accept a mobility budget invitation")
  @route("v1/mobility-budgets/accept-invitation")
  @post
  acceptMobilityBudgetInvitation(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: z91.java — @d06("v1/mobility-budgets/budget-overview/{budgetId}")
  @doc("Get overview of a mobility budget")
  @route("v1/mobility-budgets/budget-overview/{budgetId}")
  @get
  getMobilityBudgetOverview(@path budgetId: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: oc9.java — @d06("/v1/mobility-budgets/{mobilityBudgetId}/available-services")
  @doc("Get available services for a mobility budget")
  @route("v1/mobility-budgets/{mobilityBudgetId}/available-services")
  @get
  getMobilityBudgetAvailableServices(@path mobilityBudgetId: string):
    | {}
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: pja.java — @xra("/v1/store/file") — multipart upload
  @doc("Upload a file (multipart)")
  @route("v1/store/file")
  @post
  storeFile(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;
}
