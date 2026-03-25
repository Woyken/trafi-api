import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/Stop.java
@example(#{
  id: "vilnius:stop:1234",
  name: "Gedimino prospektas",
  regionId: "lithuania",
  location: #{ lat: 54.6872, lng: 25.2797 },
  type: Trafi.Enums.StopType.REGULAR,
  children: #[],
  exits: #[],
  transports: #[]
})
@doc("A transit stop (bus stop, train station, platform)")
model Stop {
  @doc("GTFS stop ID")
  id: string;
  name: string;
  regionId: string;
  location: LatLng;
  @doc("Type of stop (regular, station, platform, etc.)")
  type: Trafi.Enums.StopType;
  @doc("Child stops (e.g., platforms within a station)")
  children: Stop[];
  exits: Stop[];
  transports: TransportIcon[];
  address?: string;
  direction?: string;
  transportIds?: string[];
  parentId?: string;
  zoneId?: string;
  platformCode?: string;
  platformName?: string;
}

// Source: com/trafi/core/model/Schedule.java
@doc("A transit schedule (route/line)")
model Schedule {
  @doc("Schedule identifier")
  id: string;
  name: string;
  color: string;
  @doc("Transport mode icon and details")
  transport: Transport;
  longName?: string;
  textColor?: string;
  transportId?: string;
  transportType?: string;
}

// Source: com/trafi/core/model/StopWithSchedulesWithDepartures.java
@doc("A stop with associated schedules and departure times")
model StopWithSchedulesWithDepartures {
  stop: Stop;
  now: string;
  scheduleDepartures: ScheduleWithDepartures[];
  walkPath?: WalkPath;
}

// Source: com/trafi/core/model/NearbyStopsResponse.java
@doc("Response with nearby stops and real-time departures")
model NearbyStopsResponse {
  realtimeResponseId: string;
  stops: StopWithSchedulesWithDepartures[];
}

// Source: com/trafi/core/model/StopDeparturesResponse.java
@doc("Response with departures for a specific stop")
model StopDeparturesResponse {
  realtimeResponseId: string;
  stopDepartures: StopWithSchedulesWithDepartures;
}

// Source: com/trafi/core/model/ScheduleStopDeparturesResponse.java
@doc("Response with departures for a schedule at a stop")
model ScheduleStopDeparturesResponse {
  realtimeResponseId: string;
  scheduleDepartures: ScheduleWithStopWithDepartures;
}

// Source: com/trafi/core/model/SchedulesAndStops.java
@doc("Combined schedules and stops search results")
model SchedulesAndStops {
  schedules: Schedule[];
  stopsWithSchedules: StopWithSchedules[];
}

// Source: com/trafi/core/model/ScheduleWithStops.java
@doc("A schedule with its track stops")
model ScheduleWithStops {
  schedule: Schedule;
  tracks: TrackWithStops[];
}

// Source: com/trafi/core/model/ScheduleWithTracks.java
@doc("A schedule with its track information")
model ScheduleWithTracks {
  schedule: Schedule;
  tracks: Track[];
}

// Source: com/trafi/core/model/ScheduleWithStopWithTimes.java
@doc("Timetable for a specific stop on a schedule")
model ScheduleWithStopWithTimes {
  schedule: Schedule;
  stop: Stop;
  timetable: Times[];
  track?: Track;
}

// Source: com/trafi/core/model/TransitVehiclePositionsWithSchedule.java
@doc("Real-time vehicle positions for a schedule")
model TransitVehiclePositionsWithSchedule {
  positions: TransitVehiclePosition[];
  schedule: Schedule;
}

// Source: com/trafi/core/model/TransitTripResponse.java
@doc("Response containing a transit trip")
model TransitTripResponse {
  realtimeResponseId: string;
  trip: TransitTrip;
}

// Source: com/trafi/core/model/TransitMapObjectsRequest.java
@doc("Request for transit map objects")
model TransitMapObjectsRequest {
  mapObjectRequest: TransitObjectsRequest;
  transportIds: string[];
}

// Source: com/trafi/core/model/TransitMapObjectsResponse.java
@doc("Response with stops and vehicles for map display")
model TransitMapObjectsResponse {
  stops: StopWithSchedules[];
  transitVehicles: TransitVehiclePositionWithScheduleAndTrack[];
}

// Source: com/trafi/core/model/ScheduleTrackDirectionItem.java
@doc("Identifies a specific schedule track and direction")
model ScheduleTrackDirectionItem {
  scheduleId: string;
  trackId: string;
  direction: Trafi.Enums.TrackDirection;
}

// Placeholder models referenced by transit types
@doc("Placeholder - details not extracted from decompiled source")
model ScheduleWithDepartures {}
@doc("Placeholder - details not extracted from decompiled source")
model WalkPath {}
@doc("Placeholder - details not extracted from decompiled source")
model ScheduleWithStopWithDepartures {}
@doc("Placeholder - details not extracted from decompiled source")
model StopWithSchedules {}
@doc("Placeholder - details not extracted from decompiled source")
model TrackWithStops {}
@doc("Placeholder - details not extracted from decompiled source")
model Track {}
@doc("Placeholder - details not extracted from decompiled source")
model Times {}
@doc("Placeholder - details not extracted from decompiled source")
model TransitVehiclePosition {}
@doc("Placeholder - details not extracted from decompiled source")
model TransitTrip {}
@doc("Placeholder - details not extracted from decompiled source")
model TransitObjectsRequest {}
@doc("Placeholder - details not extracted from decompiled source")
model TransitVehiclePositionWithScheduleAndTrack {}
