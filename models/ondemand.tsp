import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/SharingBooking.java — 31 @yi7 fields
@doc("A vehicle sharing booking (scooter, bike, car)")
model SharingBooking {
  id: string;
  @doc("Current booking status")
  status: Trafi.Enums.SharingBookingStatus;
  @doc("Server time in milliseconds")
  currentTime: int64;
  provider: Provider;
  currency: string;
  fuelCards: FuelCard[];
  statusTransition?: SharingBookingStatusTransition;
  leasedAt?: string;
  endsAt?: string;
  distanceMeters?: int64;
  startTime?: int64;
  finishTime?: int64;
  startLocationTitle?: string;
  startLocation?: LatLng;
  finishLocationTitle?: string;
  finishLocation?: LatLng;
  vehicle?: SharedVehicle;
  prompt?: BookingPrompt;
  feedbackId?: string;
  priceBreakdowns?: PriceBreakdown[];
  timeRemainingSeconds?: int64;
  timeElapsedSeconds?: int64;
  purchaseBreakdown?: PurchaseBreakdown;
  notes?: Note[];
  paymentsInfo?: PaymentInfo[];
  price?: float64;
  paymentMethodId?: string;
  tripPurposeId?: string;
  promotionId?: string;
  passId?: string;
  isPriceFinal?: boolean;
}

// Source: com/trafi/core/model/RentalBooking.java — 30 @yi7 fields
@doc("A vehicle rental booking")
model RentalBooking {
  id: string;
  status: Trafi.Enums.RentalBookingStatus;
  mode: Trafi.Enums.RentalTripMode;
  currentTime: int64;
  provider: Provider;
  currency: string;
  priceBreakdowns: PriceBreakdown[];
  fuelCards: FuelCard[];
  feeInfo: BookingFeeInfo;
  restrictions: RentalBookingRestrictions;
  distanceMeters?: int64;
  startTime?: string;
  endTime?: string;
  minDuration?: Period;
  from?: RentalLocation;
  to?: RentalLocation;
  vehicle?: RentalVehicle;
  feedbackId?: string;
  deepLink?: DeepLink;
  deepLinkIos?: DeepLink;
  deepLinkAndroid?: DeepLink;
  purchaseBreakdown?: PurchaseBreakdown;
  notes?: Note[];
  paymentsInfo?: PaymentInfo[];
  price?: float64;
  paymentMethodId?: string;
  tripPurposeId?: string;
  promotionId?: string;
  passId?: string;
  isPriceFinal?: boolean;
}

// Source: com/trafi/core/model/RideHailingBooking.java — 35 @yi7 fields
@doc("A ride-hailing (taxi) booking")
model RideHailingBooking {
  id: string;
  status: Trafi.Enums.RideHailingBookingStatus;
  productDisplayName: string;
  isSharedRide: boolean;
  currentTime: int64;
  vehicleType: Trafi.Enums.VehicleType;
  provider: Provider;
  currency: string;
  statusInfo?: RideHailingBookingStatusInfo;
  operationRestrictions?: OperationRestrictions;
  driver?: Driver;
  car?: Car;
  start?: Location;
  end?: Location;
  pickup?: Location;
  dropoff?: Location;
  etaToPickupSeconds?: int32;
  etaToDropoffSeconds?: int32;
  totalTripTimeSeconds?: int32;
  startTime?: string;
  endTime?: string;
  polyline?: string;
  cancellationNotice?: string;
  requiredAction?: RequiredAction;
  feedbackId?: string;
  notes?: Note[];
  pricing?: RideHailingPricing[];
  purchaseBreakdown?: PurchaseBreakdown;
  paymentsInfo?: PaymentInfo[];
  price?: float64;
  paymentMethodId?: string;
  tripPurposeId?: string;
  promotionId?: string;
  passId?: string;
  isPriceFinal?: boolean;
}

// Source: com/trafi/core/model/SharedVehicle.java — 27 @yi7 fields
@doc("A sharing vehicle available for booking")
model SharedVehicle {
  id: string;
  providerId: string;
  @doc("Current GPS location of the vehicle")
  location: LatLng;
  type: Trafi.Enums.VehicleType;
  endLeaseSupported: boolean;
  reservationSupported: boolean;
  parkingSupported: boolean;
  requiresUserLocation: boolean;
  sustainability: SustainabilityProperties;
  damages: Damage[];
  tags: string[];
  stationId?: string;
  dockId?: string;
  name?: string;
  address?: string;
  licencePlate?: string;
  pricing?: VehiclePricing;
  imageUrl?: string;
  @doc("Battery level for electric vehicles")
  battery?: Battery;
  fuel?: Fuel;
  rangeRemaining?: int32;
  minimumDriverAge?: int32;
  isInMobilityHub?: boolean;
  deepLinkIos?: DeepLink;
  deepLinkAndroid?: DeepLink;
  localizations?: VehicleSharingLocalizations;
  subtype?: string;
}

// Source: com/trafi/core/model/RentalVehicle.java — 25 @yi7 fields
@doc("A rental vehicle available for booking")
model RentalVehicle {
  id: string;
  providerId: string;
  type: Trafi.Enums.VehicleType;
  imageUrls: string[];
  tags: Tag[];
  sustainability: SustainabilityProperties;
  isNew: boolean;
  colors: ColorModel[];
  technicalData: TechnicalData;
  configuration: Configuration[];
  subtype?: string;
  stationId?: string;
  name?: string;
  categoryName?: string;
  isFinal?: boolean;
  location?: Location;
  licencePlate?: string;
  pricing?: VehiclePricing;
  imageUrl?: string;
  battery?: Battery;
  fuel?: Fuel;
  rangeRemaining?: int32;
  deepLinks?: LocalizedDeepLink[];
  description?: string;
  availableFrom?: string;
}

// Source: com/trafi/core/model/Driver.java
@doc("Ride-hailing driver information")
model Driver {
  name: string;
  rating?: Rating;
  phoneNumber?: string;
  smsNumber?: string;
  pictureUrl?: string;
}

// Source: com/trafi/core/model/Car.java
@doc("Ride-hailing vehicle information")
model Car {
  brandAndModel: string;
  plateNumber: string;
  bearing: float64;
  latLng?: LatLng;
  pictureUrl?: string;
}

// Source: com/trafi/core/model/RideHailingOption.java
@doc("Placeholder - details not extracted from decompiled source")
model RideHailingOption {}

// ─── On-demand Request/Response Models ───

// Source: com/trafi/core/model/CreateRideHailingBookingRequest.java
@doc("Request to create a ride-hailing booking")
model CreateRideHailingBookingRequest {
  providerId: string;
  productId: string;
  requestContext: string;
  providerPaymentMethodId?: string;
  paymentMethodId?: string;
  tripPurposeId?: string;
  messagingToken?: string;
  braintreeDeviceData?: string;
  promotionId?: string;
}

// Source: com/trafi/core/model/RideHailingOptionsRequest.java
@doc("Request for ride-hailing options between two locations")
model RideHailingOptionsRequest {
  from: Location;
  to: Location;
  providerIds: string[];
  passengerCount?: int32;
  wheelchairAccessibleOnly?: boolean;
}

// Source: com/trafi/core/model/RideHailingOptionsResponse.java
@doc("Response with ride-hailing options and pricing")
model RideHailingOptionsResponse {
  options: RideHailingOption[];
  providersWithRequirements: ProviderWithRequirements[];
  offerDurationSeconds: int64;
  offerTimeoutSeconds?: int32;
}

// Source: com/trafi/core/model/SharingNearbyRequest.java
@doc("Request for nearby sharing vehicles")
model SharingNearbyRequest {
  providerIds?: string[];
  vehicleFilters?: SharingVehicleFilter[];
  vehicleId?: string;
  stationId?: string;
  userLat?: float64;
  userLng?: float64;
}

// Source: com/trafi/core/model/SharingNearbyResponse.java
@doc("Response with nearby vehicles and zones")
model SharingNearbyResponse {
  providers: Provider[];
  vehicles: SharedVehicle[];
  vehicleGroups: VehicleGroup[];
  zones: Zone[];
  zoneTypes: ZoneType[];
  providerPaymentMethods: ProviderPaymentMethods[];
}

// Source: com/trafi/core/model/RentalListRequest.java
@doc("Request for available rental vehicles")
model RentalListRequest {
  providerIds: string;
  vehicleType: Trafi.Enums.VehicleType;
  mode: Trafi.Enums.RentalTripMode;
  startTime?: string;
  endTime?: string;
  fromStationId?: string;
  userLocation?: LatLng;
  filters?: FilterSelection[];
}

// Source: com/trafi/core/model/RentalListResponse.java
@doc("Response with available rental stations")
model RentalListResponse {
  stations: RentalStationWithAvailabilities[];
}

// Source: com/trafi/core/model/SharingMapRequest.java
@doc("Request for sharing map overlay data")
model SharingMapRequest {
  northEast: LatLng;
  southWest: LatLng;
  providerIds?: string;
  vehicleType?: Trafi.Enums.VehicleType;
  vehicleFilters?: SharingVehicleFilter[];
  categoryId?: string;
}

// Source: com/trafi/core/model/SharingMapResponse.java
@doc("Response with vehicles and zones for map display")
model SharingMapResponse {
  sharedVehicles: ProviderWithVehicles[];
  sharedGroups: ProviderWithGroups[];
  zones: Zone[];
  zoneTypes: ZoneType[];
}
