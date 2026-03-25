import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: c64.java, d2f.java, g4a.java, gjc.java, k7f.java — Transit API
@tag("Transit")
@route("/")
interface Transit {
  // Source: g4a.java — @d06("v1/transit/stops/nearby/realtime")
  @doc("Get nearby transit stops with real-time departures")
  @route("v1/transit/stops/nearby/realtime")
  @get
  getNearbyStops(
    @query lat: float64,
    @query lng: float64,
    @query transportIds: string,
  ): Trafi.Models.NearbyStopsResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: c64.java — @d06("v1/transit/stops/{stopId}/schedules/departures/realtime")
  @doc("Get real-time departures for a specific stop")
  @route("v1/transit/stops/{stopId}/schedules/departures/realtime")
  @get
  getStopDepartures(
    @path stopId: string,
    @query toStopId: string,
    @query limitPerScheduleTrack: int32,
    @query timeDurationFromNow: string,
  ):
    | Trafi.Models.StopDeparturesResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: c64.java — @d06("v1/transit/stops/{stopId}/vehicles")
  @doc("Get vehicle positions near a stop")
  @route("v1/transit/stops/{stopId}/vehicles")
  @get
  getStopVehicles(@path stopId: string, @query toStopId: string):
    | Trafi.Models.TransitVehiclePositionsWithSchedule[]
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: c64.java — @d06("v1/transit/schedules/tracks")
  @doc("Get schedule tracks for specified stops")
  @route("v1/transit/schedules/tracks")
  @get
  getScheduleTracks(
    @query stopIds: string,
    @query transportIds: string,
    @query subregionId: string,
    @query visibleTracksOnly: boolean,
  ): Trafi.Models.ScheduleWithTracks[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: d2f.java — @d06("v1/transit/schedules")
  @doc("Get transit schedules filtered by transport type")
  @route("v1/transit/schedules")
  @get
  getSchedules(
    @query transportIds: string,
  ): Trafi.Models.Schedule[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: d2f.java — @d06("v1/transit/schedules/{scheduleId}/tracks/stops")
  @doc("Get stops along a schedule's tracks")
  @route("v1/transit/schedules/{scheduleId}/tracks/stops")
  @get
  getScheduleStops(
    @path scheduleId: string,
    @query visibleTracksOnly: boolean,
  ):
    | Trafi.Models.ScheduleWithStops
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: d2f.java — @d06("v1/transit/schedules/{scheduleId}/stop/times")
  @doc("Get timetable for a specific stop on a schedule")
  @route("v1/transit/schedules/{scheduleId}/stop/times")
  @get
  getScheduleStopTimes(
    @path scheduleId: string,
    @query direction: string,
    @query stopId: string,
    @query mainTrackId: string,
  ):
    | Trafi.Models.ScheduleWithStopWithTimes
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: d2f.java — @d06("v1/transit/schedules/{scheduleId}/stop/departures/realtime")
  @doc("Get real-time departures for a schedule at a stop")
  @route("v1/transit/schedules/{scheduleId}/stop/departures/realtime")
  @get
  getScheduleStopDepartures(
    @path scheduleId: string,
    @query direction: string,
    @query stopId: string,
  ):
    | Trafi.Models.ScheduleStopDeparturesResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: k7f.java — @d06("v1/transit/search/{infix}")
  @doc("Search for transit schedules and stops by name")
  @route("v1/transit/search/{infix}")
  @get
  searchTransit(@path infix: string, @query subregionId: string):
    | Trafi.Models.SchedulesAndStops
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: k7f.java — @d06("v1/transit/stops")
  @doc("Get transit stops within geographic bounds")
  @route("v1/transit/stops")
  @get
  getStops(
    @query `bounds.southLat`: float64,
    @query `bounds.northLat`: float64,
    @query `bounds.westLng`: float64,
    @query `bounds.eastLng`: float64,
    @query transportIds: string,
    @query activeSchedulesOnly: boolean,
    @query namePrefix: string,
    @query nameInfix: string,
    @query stopIds: string,
    @query subregionId: string,
  ): Trafi.Models.Stop[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: gjc.java — @xra("/v1/transit/map/objects")
  @doc("Get transit map objects including stops and vehicles")
  @route("v1/transit/map/objects")
  @post
  getMapObjects(@body body: Trafi.Models.TransitMapObjectsRequest):
    | Trafi.Models.TransitMapObjectsResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: gjc.java — @xra("/v1/transit/stops/schedules/nearby/realtime")
  @doc("Get nearby stops with full schedule information")
  @route("v1/transit/stops/schedules/nearby/realtime")
  @post
  getNearbyStopsWithSchedules(@body body: {}):
    | Trafi.Models.NearbyStopsResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: kne.java — @xra("v1/transit/vehicles")
  @doc("Get real-time vehicle positions for schedule tracks")
  @route("v1/transit/vehicles")
  @post
  getVehiclePositions(@body body: Trafi.Models.ScheduleTrackDirectionItem[]):
    | Trafi.Models.TransitVehiclePositionsWithSchedule[]
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @d06("v1/transit/stops/nearby") — distinct from /nearby/realtime
  @doc("Get nearby stops with basic departure info")
  @route("v1/transit/stops/nearby")
  @get
  getNearbyStopsBasic(
    @query lat: float64,
    @query lng: float64,
  ): Trafi.Models.StopWithSchedulesWithDepartures[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: s4j.java — @d06("v1/transit/vehicles")
  // GET variant of transit vehicles (s4j.java), distinct from POST (kne.java)
  @doc("Get vehicle positions for a specific schedule track")
  @route("v1/transit/vehicles")
  @get
  getVehiclePositionsGet(
    @query scheduleId: string,
    @query trackId: string,
    @query direction: string,
  ): Trafi.Models.TransitVehiclePositionsWithSchedule[] | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: v3i.java — @d06("v1/transit/trip/realtime")
  @doc("Get real-time trip information")
  @route("v1/transit/trip/realtime")
  @get
  getTransitTripRealtime(
    @query tripId: string,
    @query stopId?: string,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;
}
