import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: kne.java — Route Search API
// Source: InterfaceC8102og.java — Active Trip API
@tag("Routing")
@route("/")
interface Routing {
  // Source: kne.java — @xra("v2/routes")
  @doc("Search for multimodal routes between two points")
  @route("v2/routes")
  @post
  searchRoutes(@body body: Trafi.Models.RouteSearchRequest):
    | Trafi.Models.RouteSearchResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java / kne.java — @d06("v1/directions/walking")
  @doc("Get walking directions between two points")
  @route("v1/directions/walking")
  @get
  getWalkingDirections(
    @query `start.Lat`: float64,
    @query `start.Lng`: float64,
    @query `end.Lat`: float64,
    @query `end.Lng`: float64,
  ): Trafi.Models.WalkPathResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC8102og.java — @xra("v1/activetrip/start")
  @doc("Start navigating an active trip")
  @route("v1/activetrip/start")
  @post
  startActiveTrip(@body body: Trafi.Models.GetActiveTripStepsRequest):
    | Trafi.Models.GetActiveTripStepsResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC8102og.java — @wra("v1/activetrip")
  @doc("Update the current position during an active trip")
  @route("v1/activetrip")
  @patch
  updateActiveTrip(@body body: Trafi.Models.UpdateActiveTripStepsRequest):
    | Trafi.Models.ActiveTripSteps
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC8102og.java — @xra("v1/activetrip/feedback")
  @doc("Submit feedback for an active trip")
  @route("v1/activetrip/feedback")
  @post
  submitActiveTripFeedback(@body body: {}):
    | void
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: InterfaceC8102og.java — @xra("v1/activetrip/tracking")
  @doc("Submit tracking data during an active trip")
  @route("v1/activetrip/tracking")
  @post
  submitActiveTripTracking(@body body: {}):
    | void
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;
}
