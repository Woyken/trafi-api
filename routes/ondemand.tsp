import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: sja.java — Sharing/On-Demand API (44 endpoints)
// Source: ard.java — Rental API (8 endpoints)
@tag("OnDemand")
@route("/")
interface OnDemand {
  // ─── Sharing - Vehicle Discovery ───

  // Source: sja.java — @d06("v1/ondemand/sharing/providers")
  @doc("Get available sharing providers")
  @route("v1/ondemand/sharing/providers")
  @get
  getSharingProviders(
    @query supportsInstantUnlock: boolean,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @d06("v1/ondemand/sharing/vehicle")
  @doc("Get vehicle details by provider and vehicle ID")
  @route("v1/ondemand/sharing/vehicle")
  @get
  getVehicle(
    @query providerId: string,
    @query vehicleId: string,
    @query userLat: float64,
    @query userLng: float64,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @d06("v1/ondemand/sharing/vehicle/qr")
  @doc("Look up a vehicle by QR code")
  @route("v1/ondemand/sharing/vehicle/qr")
  @get
  getVehicleByQr(
    @query qrCode: string,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @d06("v1/ondemand/sharing/vehicle/public/id")
  @doc("Look up a vehicle by public ID")
  @route("v1/ondemand/sharing/vehicle/public/id")
  @get
  getVehicleByPublicId(
    @query providerId: string,
    @query publicId: string,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @d06("v1/ondemand/sharing/vehicle/nfc")
  @doc("Look up a vehicle by NFC data")
  @route("v1/ondemand/sharing/vehicle/nfc")
  @get
  getVehicleByNfc(
    @query nfcTechType: string,
    @query encodedNfcData: string,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v1/ondemand/sharing/booking/vehicle")
  @doc("Get vehicle assigned to a booking")
  @route("v1/ondemand/sharing/booking/vehicle")
  @post
  getBookingVehicle(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v2/ondemand/sharing/nearby")
  @doc("Find nearby sharing vehicles")
  @route("v2/ondemand/sharing/nearby")
  @post
  getNearbyVehicles(@body body: Trafi.Models.SharingNearbyRequest):
    | Trafi.Models.SharingNearbyResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v1/ondemand/sharing/map/objects")
  @doc("Get sharing vehicles and zones for map display")
  @route("v1/ondemand/sharing/map/objects")
  @post
  getSharingMapObjects(@body body: Trafi.Models.SharingMapRequest):
    | Trafi.Models.SharingMapResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v2/ondemand/sharing/vehicle/group")
  @doc("Get a group of vehicles at a station")
  @route("v2/ondemand/sharing/vehicle/group")
  @post
  getVehicleGroup(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v2/ondemand/sharing/list/uncategorized")
  @doc("Get uncategorized vehicle list for a provider")
  @route("v2/ondemand/sharing/list/uncategorized")
  @post
  getProviderFleet(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Sharing - Booking Lifecycle ───

  // Source: sja.java — @d06("v1/ondemand/sharing/bookings/{bookingId}")
  @doc("Get details of a sharing booking")
  @route("v1/ondemand/sharing/bookings/{bookingId}")
  @get
  getSharingBooking(@path bookingId: string):
    | Trafi.Models.SharingBooking
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v2/ondemand/sharing/bookings/start")
  @doc("Start a new sharing vehicle reservation")
  @route("v2/ondemand/sharing/bookings/start")
  @post
  startSharingReservation(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v2/ondemand/sharing/bookings/{purchaseSessionId}/confirm")
  @doc("Confirm a pending sharing reservation")
  @route("v2/ondemand/sharing/bookings/{purchaseSessionId}/confirm")
  @post
  confirmSharingReservation(@path purchaseSessionId: string):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @ae6("v2/ondemand/sharing/bookings/{purchaseSessionId}/cancel")
  @doc("Cancel a sharing reservation")
  @route("v2/ondemand/sharing/bookings/{purchaseSessionId}/cancel")
  @delete
  cancelSharingReservation(@path purchaseSessionId: string):
    | Trafi.Models.EmptySuccessResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v1/ondemand/sharing/bookings/lease/start")
  @doc("Start the lease of a reserved sharing vehicle")
  @route("v1/ondemand/sharing/bookings/lease/start")
  @post
  startSharingLease(@body body: {}):
    | Trafi.Models.SharingBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v1/ondemand/sharing/bookings/lease/pause")
  @doc("Pause an active sharing lease")
  @route("v1/ondemand/sharing/bookings/lease/pause")
  @post
  pauseSharingLease(@body body: {}):
    | Trafi.Models.SharingBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v1/ondemand/sharing/bookings/lease/resume")
  @doc("Resume a paused sharing lease")
  @route("v1/ondemand/sharing/bookings/lease/resume")
  @post
  resumeSharingLease(@body body: {}):
    | Trafi.Models.SharingBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v1/ondemand/sharing/bookings/lease/end")
  @doc("End an active sharing lease and return the vehicle")
  @route("v1/ondemand/sharing/bookings/lease/end")
  @post
  endSharingLease(@body body: {}):
    | Trafi.Models.SharingBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @xra("v1/ondemand/sharing/bookings/reservation/cancel")
  @doc("Cancel a sharing reservation (legacy endpoint)")
  @route("v1/ondemand/sharing/bookings/reservation/cancel")
  @post
  cancelSharingReservationLegacy(@body body: {}):
    | Trafi.Models.SharingBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: sja.java — @d06("/v1/ondemand/sharing/return/options")
  @doc("Get available return locations for a sharing vehicle")
  @route("v1/ondemand/sharing/return/options")
  @get
  getSharingReturnOptions(
    @query bookingId: string,
    @query lat: float64,
    @query lng: float64,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // ─── Ride-Hailing ───

  // Source: sja.java — @xra("v1/ondemand/ridehailing/options")
  @doc("Get ride-hailing price estimates and options")
  @route("v1/ondemand/ridehailing/options")
  @post
  getRideHailingOptions(@body body: Trafi.Models.RideHailingOptionsRequest):
    | Trafi.Models.RideHailingOptionsResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: q11.java — @d06("v1/ondemand/ridehailing/bookings/{bookingId}")
  @doc("Get details of a ride-hailing booking")
  @route("v1/ondemand/ridehailing/bookings/{bookingId}")
  @get
  getRideHailingBooking(@path bookingId: string):
    | Trafi.Models.RideHailingBooking
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Rental ───

  // Source: ard.java — @d06("v1/ondemand/rental/providers")
  @doc("Get available rental providers")
  @route("v1/ondemand/rental/providers")
  @get
  getRentalProviders(
    @query vehicleType: string,
    @query providerIds: string,
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: ard.java — @xra("v1/ondemand/rental/list")
  @doc("Get available rental vehicles")
  @route("v1/ondemand/rental/list")
  @post
  getRentalList(@body body: Trafi.Models.RentalListRequest):
    | Trafi.Models.RentalListResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ard.java — @xra("/v1/ondemand/rental/map/objects")
  @doc("Get rental stations and vehicles for map display")
  @route("v1/ondemand/rental/map/objects")
  @post
  getRentalMapObjects(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ard.java — @xra("v1/ondemand/rental/bookings")
  @doc("Create a new rental booking")
  @route("v1/ondemand/rental/bookings")
  @post
  createRentalBooking(@body body: {}):
    | Trafi.Models.RentalBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ard.java — @d06("v1/ondemand/rental/bookings/{bookingId}")
  @doc("Get details of a rental booking")
  @route("v1/ondemand/rental/bookings/{bookingId}")
  @get
  getRentalBooking(@path bookingId: string):
    | Trafi.Models.RentalBooking
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ard.java — @wra("v1/ondemand/rental/bookings/{bookingId}/status")
  @doc("Update the status of a rental booking")
  @route("v1/ondemand/rental/bookings/{bookingId}/status")
  @patch
  updateRentalBookingStatus(@path bookingId: string, @body body: {}):
    | Trafi.Models.RentalBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ard.java — @wra("v1/ondemand/rental/bookings/{bookingId}/trip")
  @doc("Update trip details of a rental booking")
  @route("v1/ondemand/rental/bookings/{bookingId}/trip")
  @patch
  updateRentalBookingTrip(@path bookingId: string, @body body: {}):
    | Trafi.Models.RentalBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.NotFoundResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Ride-Hailing (additional from o7e.java, sde.java) ───

  // Source: sde.java — @d06("v1/ondemand/ridehailing/products")
  @doc("Get available ride-hailing products")
  @route("v1/ondemand/ridehailing/products")
  @get
  getRideHailingProducts(
  ): {} | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  // Source: o7e.java — @xra("v1/ondemand/ridehailing/bookings/create")
  @doc("Create a ride-hailing booking")
  @route("v1/ondemand/ridehailing/bookings/create")
  @post
  createRideHailingBookingV2(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: o7e.java — @xra("v1/ondemand/ridehailing/bookings/cancel")
  @doc("Cancel a ride-hailing booking")
  @route("v1/ondemand/ridehailing/bookings/cancel")
  @post
  cancelRideHailingBookingV2(@body body: {}):
    | Trafi.Models.RideHailingBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: o7e.java — @xra("v1/ondemand/ridehailing/bookings/update")
  @doc("Update a ride-hailing booking")
  @route("v1/ondemand/ridehailing/bookings/update")
  @post
  updateRideHailingBooking(@body body: {}):
    | Trafi.Models.RideHailingBooking
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // ─── Damage Report (qja.java) ───

  // Source: qja.java — @xra("v1/ondemand/damage-report/initiate")
  @doc("Initiate a vehicle damage report")
  @route("v1/ondemand/damage-report/initiate")
  @post
  initiateDamageReport(@body body: {}):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;
}
