import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/Route.java
@doc("A multimodal route between two locations")
model Route {
  id: string;
  isAccessible: boolean;
  segments: RouteSegment[];
  @doc("ISO 8601 departure time")
  startTime: string;
  @doc("ISO 8601 arrival time")
  endTime: string;
  duration: IntervalDuration;
  distance: PlatformDistance;
  isAvailable: boolean;
  @doc("Risk assessment of the route start")
  riskiness: Trafi.Enums.RouteRiskiness;
  firstTransitSegmentExactDepartures: RouteExactDeparture[];
  sustainability: SustainabilityProperties;
  groupId?: string;
  fare?: RouteFare;
  intervalEndTime?: TimeInterval;
  labelKey?: string;
  disruption?: RouteDisruption;
}

// Source: com/trafi/core/model/RouteSearchRequest.java
@example(#{
  startLat: 54.6872,
  startLng: 25.2797,
  endLat: 54.6892,
  endLng: 25.2637,
  startName: "Gedimino pr.",
  endName: "Vilnius train station"
})
@doc("Request to search for routes")
model RouteSearchRequest {
  @doc("Start location latitude")
  startLat: float64;
  @doc("Start location longitude")
  startLng: float64;
  @doc("End location latitude")
  endLat: float64;
  @doc("End location longitude")
  endLng: float64;
  startName?: string;
  endName?: string;
  time?: string;
  isArrival?: boolean;
  abFlags?: string;
  criteriaTag?: string;
  searchId?: string;
  personalVehiclesFilter?: Trafi.Enums.PersonalVehicleType[];
  sharingVehiclesFilter?: SharingVehicleFilter[];
  transportGroupsFilter?: string[];
}

// Source: com/trafi/core/model/RouteSearchResponse.java
@doc("Response containing found routes")
model RouteSearchResponse {
  id: string;
  now: string;
  routes: Route[];
  preferredRouteId?: string;
  groups?: Group[];
}

// Source: com/trafi/core/model/GetActiveTripStepsRequest.java
@doc("Request to start navigating a route")
model GetActiveTripStepsRequest {
  route: Route;
  routeSearchResponseId?: string;
  user?: LatLng;
}

// Source: com/trafi/core/model/GetActiveTripStepsResponse.java
@doc("Response with step-by-step navigation")
model GetActiveTripStepsResponse {
  activeTripSteps: ActiveTripSteps;
  feedbackConfig?: ActiveTripStepFeedbackConfig;
}

// Source: com/trafi/core/model/ActiveTripSteps.java
@doc("Navigation steps for an active trip")
model ActiveTripSteps {
  @doc("Unique identifier for the active trip session")
  activeTripId: string;
  steps: ActiveTripStep[];
  startTime: string;
  endTime: string;
  duration: Duration;
  activeStepIndex?: int32;
}

// Source: com/trafi/core/model/UpdateActiveTripStepsRequest.java
@doc("Request to update position during navigation")
model UpdateActiveTripStepsRequest {
  activeTripSteps: ActiveTripSteps;
  user?: LatLng;
}

// Source: com/trafi/core/model/WalkPathResponse.java
@doc("Response containing walking path geometry")
model WalkPathResponse {
  path?: WalkPath;
}

// Placeholder models referenced by routing types
@doc("Placeholder - details not extracted from decompiled source")
model RouteSegment {}
@doc("Placeholder - details not extracted from decompiled source")
model IntervalDuration {}
@doc("Placeholder - details not extracted from decompiled source")
model PlatformDistance {}
@doc("Placeholder - details not extracted from decompiled source")
model RouteExactDeparture {}
@doc("Placeholder - details not extracted from decompiled source")
model RouteFare {}
@doc("Placeholder - details not extracted from decompiled source")
model TimeInterval {}
@doc("Placeholder - details not extracted from decompiled source")
model RouteDisruption {}
@doc("Placeholder - details not extracted from decompiled source")
model Group {}
@doc("Placeholder - details not extracted from decompiled source")
model ActiveTripStep {}
@doc("Placeholder - details not extracted from decompiled source")
model Duration {}
@doc("Placeholder - details not extracted from decompiled source")
model ActiveTripStepFeedbackConfig {}
