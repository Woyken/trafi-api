import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Enums;

// Source: com/trafi/core/model/TicketStatus.java lines 29-57
@doc("Status of a transit ticket")
enum TicketStatus {
  NONE,
  UNUSED,
  ACTIVE,
  ENDED,
  EXPIRED,
  SCHEDULED,
  PENDING,
  READY,
  REJECTED,
  BLOCKED,
}

// Source: com/trafi/core/model/TicketSubscriptionStatus.java
@doc("Status of a ticket subscription")
enum TicketSubscriptionStatus {
  UNKNOWN,
  PENDING,
  ACTIVE,
  CANCELED,
}

// Source: com/trafi/core/model/SharingBookingStatus.java
@doc("Status of a vehicle sharing booking")
enum SharingBookingStatus {
  RESERVED,
  LEASED,
  FINISHED,
  CANCELED,
  PAUSED,
}

// Source: com/trafi/core/model/RentalBookingStatus.java
@doc("Status of a vehicle rental booking")
enum RentalBookingStatus {
  RESERVED,
  LEASED,
  FINISHED,
  CANCELED,
  PENDING,
}

// Source: com/trafi/core/model/RideHailingBookingStatus.java
@doc("Status of a ride-hailing booking")
enum RideHailingBookingStatus {
  UNKNOWN,
  REQUESTING,
  DRIVER_ARRIVING,
  DRIVER_ARRIVED,
  CANCELLED,
  RIDING,
  FINISHED,
  NO_DRIVERS_AVAILABLE,
}

// Source: com/trafi/core/model/RentalTripMode.java
@doc("Trip mode for rental bookings")
enum RentalTripMode {
  NONE,
  ROUND_TRIP,
  ONE_WAY_TRIP,
}

// Source: com/trafi/core/model/VehicleType.java
@doc("Type of vehicle")
enum VehicleType {
  UNKNOWN,
  CAR,
  SCOOTER,
  BIKE,
  KICK_SCOOTER,
}

// Source: com/trafi/core/model/StopType.java — verified 2026-03-25
@doc("Type of transit stop")
enum StopType {
  REGULAR,
  EXIT,
  PLATFORM,
  GENERIC_NODE,
  BOARDING_AREA,
  STATION,
}

// Source: com/trafi/core/model/Gender.java
@doc("User gender")
enum Gender {
  UNSPECIFIED,
  MALE,
  FEMALE,
  OTHER,
}

// Source: com/trafi/core/model/VerificationStatus.java — verified 2026-03-25
@doc("Status of identity verification")
enum VerificationStatus {
  NOT_VERIFIED,
  VERIFIED,
  PENDING,
  FAILED,
  EXPIRED,
  REVOKED,
}

// Source: com/trafi/core/model/PaymentMethodType.java
@doc("Type of payment method")
enum PaymentMethodType {
  UNKNOWN,
  CREDIT_CARD,
  DIRECT_DEBIT,
  PAYPAL,
  PRE_PAY,
  DIGITAL_WALLET,
  MOBILITY_BUDGET,
}

// Source: com/trafi/core/model/ProviderAccountType.java
@doc("Type of provider account")
enum ProviderAccountType {
  TRAFI,
  PROVIDER,
}

// Source: com/trafi/core/model/MembershipType.java
@doc("Type of membership")
enum MembershipType {
  UNKNOWN,
}

// Source: com/trafi/core/model/ChallengeType.java — verified 2026-03-25
@doc("Type of payment challenge")
enum ChallengeType {
  CVV,
  SCA,
}

// Source: com/trafi/core/model/TrackDirection.java
@doc("Direction of a transit track")
enum TrackDirection {
  UNKNOWN,
  INBOUND,
  OUTBOUND,
}

// Source: com/trafi/core/model/PersonalVehicleType.java
@doc("Type of personal vehicle for route filtering")
enum PersonalVehicleType {
  UNKNOWN,
  CAR,
  BICYCLE,
}

// Source: com/trafi/core/model/RouteRiskiness.java — verified 2026-03-25
@doc("Risk level of a route")
enum RouteRiskiness {
  NONE,
  RISKY_START,
}

// Source: com/trafi/core/model/IconTypeValue.java
@doc("Transit vehicle icon type")
enum IconTypeValue {
  UNKNOWN,
  BUS,
  TROLLEYBUS,
  TRAM,
  RAIL,
  METRO,
  FERRY,
  CABLE_CAR,
  FUNICULAR,
  MONORAIL,
}
