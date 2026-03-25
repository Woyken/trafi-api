import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// ─── Error Response Models ───
// Based on ApiError model from com/trafi/core/model/Error.java

@doc("Bad request — missing required headers (e.g., x-device-id) or invalid parameters")
@error
model BadRequestResponse {
  @statusCode statusCode: 400;
  @body body: ApiError;
}

@doc("Unauthorized — missing, invalid, or expired Firebase idToken")
@error
model UnauthorizedResponse {
  @statusCode statusCode: 401;
  @body body: ApiError;
}

@doc("Forbidden — insufficient permissions for the requested operation")
@error
model ForbiddenResponse {
  @statusCode statusCode: 403;
  @body body: ApiError;
}

@doc("Not found — the requested resource does not exist")
@error
model NotFoundResponse {
  @statusCode statusCode: 404;
  @body body: ApiError;
}

@doc("Internal server error")
@error
model InternalServerErrorResponse {
  @statusCode statusCode: 500;
  @body body: ApiError;
}

// Source: com/trafi/core/model/LatLng.java
@doc("Geographic coordinates")
model LatLng {
  lat: float64;
  lng: float64;
}

// Source: com/trafi/core/model/Location.java
@doc("A named geographic location")
model Location {
  coordinate: LatLng;
  name?: string;
  address?: string;
}

// Source: com/trafi/core/model/DeepLink.java
@doc("Deep link URLs for app and web")
model DeepLink {
  appLink?: string;
  webUrl?: string;
}

// Source: com/trafi/core/model/ServerTime.java
@example(#{
  currentTimeMillis: 1711360500000
})
@doc("Server time response")
model ServerTime {
  @doc("Current server time in milliseconds since epoch")
  currentTimeMillis: int64;
}

// Source: com/trafi/core/model/EmptySuccessResponse.java
@doc("Generic success response")
model EmptySuccessResponse {
  success: boolean;
}

// Source: com/trafi/core/model/Error.java
@example(#{
  errorCode: "UNAUTHORIZED",
  message: "Invalid or expired token",
  errorTitle: "Authentication Error",
  errorMessage: "Please sign in again"
})
@doc("API error details")
model ApiError {
  developerMessage?: string;
  errorCode?: string;
  message?: string;
  errorTitle?: string;
  errorMessage?: string;
  analyticsId?: string;
  traceId?: string;
  providerWithRequirements?: ProviderWithRequirements;
  details?: ErrorDetails;
}

// Placeholder for ErrorDetails — exact fields not extracted
@doc("Placeholder - details not extracted from decompiled source")
model ErrorDetails {}

// Placeholder for ProviderWithRequirements — referenced by Error
@doc("Placeholder - details not extracted from decompiled source")
model ProviderWithRequirements {}

// Source: com/trafi/core/model/IconType.java
@doc("Icon type with transport mode")
model IconType {
  value: Trafi.Enums.IconTypeValue;
  name?: string;
}

// Source: com/trafi/core/model/InfoMessage.java
@doc("Informational message displayed to users")
model InfoMessage {
  text: string;
  title?: string;
  icon?: string;
}

// Source: com/trafi/core/model/Note.java
@doc("A note attached to a booking")
model Note {
  type?: string;
  text?: string;
}

// Source: com/trafi/core/model/PaymentChallenge.java
@doc("Payment challenge requiring user action (e.g., 3D Secure)")
model PaymentChallenge {
  @doc("URL to redirect the user for payment verification")
  challengeUrl: string;
  @doc("Session ID to confirm the purchase after challenge")
  purchaseSessionId: string;
  challengeType?: Trafi.Enums.ChallengeType;
}

// Source: com/trafi/core/model/PriceBreakdown.java
@doc("Line item in a price breakdown")
model PriceBreakdown {
  id: string;
  name: string;
  price: string;
  category?: string;
}

// Source: com/trafi/core/model/PurchaseBreakdown.java
@doc("Total price breakdown for a purchase")
model PurchaseBreakdown {
  total: string;
  purchaseBreakdownItems: PurchaseBreakdownItem[];
  original?: string;
  suffix?: string;
}

// Placeholder — exact fields not separately extracted
@doc("Placeholder - details not extracted from decompiled source")
model PurchaseBreakdownItem {}

// Source: com/trafi/core/model/SupportContact.java
@doc("Placeholder - details not extracted from decompiled source")
model SupportContact {}

// Source: com/trafi/core/model/SupportInfo.java
@doc("Placeholder - details not extracted from decompiled source")
model SupportInfo {}

// Source: com/trafi/core/model/Faq.java
@doc("Placeholder - details not extracted from decompiled source")
model Faq {}

// Source: com/trafi/core/model/HowItWorks.java
@doc("Placeholder - details not extracted from decompiled source")
model HowItWorks {}

// Source: com/trafi/core/model/ProviderPricing.java
@doc("Placeholder - details not extracted from decompiled source")
model ProviderPricing {}

// Source: com/trafi/core/model/VehiclePricing.java
@doc("Placeholder - details not extracted from decompiled source")
model VehiclePricing {}

// Source: com/trafi/core/model/InstantUnlockData.java
@doc("Placeholder - details not extracted from decompiled source")
model InstantUnlockData {}

// Source: com/trafi/core/model/SharingProviderOptions.java
@doc("Placeholder - details not extracted from decompiled source")
model SharingProviderOptions {}

// Source: com/trafi/core/model/RentalProviderOptions.java
@doc("Placeholder - details not extracted from decompiled source")
model RentalProviderOptions {}

// Source: com/trafi/core/model/TicketsProviderOptions.java
@doc("Placeholder - details not extracted from decompiled source")
model TicketsProviderOptions {}

// Source: com/trafi/core/model/ProviderResources.java
@doc("Placeholder - details not extracted from decompiled source")
model ProviderResources {}

// Source: com/trafi/core/model/ProviderFeatures.java
@doc("Placeholder - details not extracted from decompiled source")
model ProviderFeatures {}

// Source: com/trafi/core/model/Property.java
@doc("Placeholder - details not extracted from decompiled source")
model Property {}

// Source: com/trafi/core/model/Provider.java
@doc("A transport or mobility service provider")
model Provider {
  @doc("Unique provider identifier")
  id: string;
  @doc("Display name of the provider")
  name: string;
  color: string;
  transportIcon: string;
  @doc("Whether the provider supports wheelchair accessibility")
  wheelchairAccessible: boolean;
  supportContacts: SupportContact[];
  features: ProviderFeatures;
  properties: Property[];
  idPrefix?: string;
  accentColor?: string;
  about?: string;
  icon?: string;
  isLevel3?: boolean;
  supportInfo?: SupportInfo;
  faq?: Faq;
  howItWorks?: HowItWorks;
  providerPricing?: ProviderPricing;
  sharingPricing?: VehiclePricing;
  rentalPricing?: VehiclePricing;
  instantUnlockData?: InstantUnlockData;
  sharingOptions?: SharingProviderOptions[];
  rentalOptions?: RentalProviderOptions[];
  ticketOptions?: TicketsProviderOptions;
  resources?: ProviderResources;
}

// Source: com/trafi/core/model/TransportIcon.java
@doc("Placeholder - details not extracted from decompiled source")
model TransportIcon {}

// Source: com/trafi/core/model/Transport.java
@doc("Placeholder - details not extracted from decompiled source")
model Transport {}

// Source: com/trafi/core/model/PaymentInfo.java
@doc("Placeholder - details not extracted from decompiled source")
model PaymentInfo {}

// Source: com/trafi/core/model/ManualItem.java
@doc("Placeholder - details not extracted from decompiled source")
model ManualItem {}

// Source: com/trafi/core/model/SustainabilityProperties.java
@doc("Placeholder - details not extracted from decompiled source")
model SustainabilityProperties {}

// Source: com/trafi/core/model/Rating.java
@doc("Placeholder - details not extracted from decompiled source")
model Rating {}

// Source: com/trafi/core/model/Battery.java
@doc("Placeholder - details not extracted from decompiled source")
model Battery {}

// Source: com/trafi/core/model/Fuel.java
@doc("Placeholder - details not extracted from decompiled source")
model Fuel {}

// Source: com/trafi/core/model/Tag.java
@doc("Placeholder - details not extracted from decompiled source")
model Tag {}

// Source: com/trafi/core/model/Color.java
@doc("Placeholder - details not extracted from decompiled source")
model ColorModel {}

// Source: com/trafi/core/model/TechnicalData.java
@doc("Placeholder - details not extracted from decompiled source")
model TechnicalData {}

// Source: com/trafi/core/model/Configuration.java
@doc("Placeholder - details not extracted from decompiled source")
model Configuration {}

// Source: com/trafi/core/model/LocalizedDeepLink.java
@doc("Placeholder - details not extracted from decompiled source")
model LocalizedDeepLink {}

// Source: com/trafi/core/model/Damage.java
@doc("Placeholder - details not extracted from decompiled source")
model Damage {}

// Source: com/trafi/core/model/BookingFeeInfo.java
@doc("Placeholder - details not extracted from decompiled source")
model BookingFeeInfo {}

// Source: com/trafi/core/model/RentalBookingRestrictions.java
@doc("Placeholder - details not extracted from decompiled source")
model RentalBookingRestrictions {}

// Source: com/trafi/core/model/Period.java
@doc("Placeholder - details not extracted from decompiled source")
model Period {}

// Source: com/trafi/core/model/RentalLocation.java
@doc("Placeholder - details not extracted from decompiled source")
model RentalLocation {}

// Source: com/trafi/core/model/FilterSelection.java
@doc("Placeholder - details not extracted from decompiled source")
model FilterSelection {}

// Source: com/trafi/core/model/Zone.java
@doc("Placeholder - details not extracted from decompiled source")
model Zone {}

// Source: com/trafi/core/model/ZoneType.java
@doc("Placeholder - details not extracted from decompiled source")
model ZoneType {}

// Source: com/trafi/core/model/VehicleGroup.java
@doc("Placeholder - details not extracted from decompiled source")
model VehicleGroup {}

// Source: com/trafi/core/model/ProviderPaymentMethods.java
@doc("Placeholder - details not extracted from decompiled source")
model ProviderPaymentMethods {}

// Source: com/trafi/core/model/ProviderWithVehicles.java
@doc("Placeholder - details not extracted from decompiled source")
model ProviderWithVehicles {}

// Source: com/trafi/core/model/ProviderWithGroups.java
@doc("Placeholder - details not extracted from decompiled source")
model ProviderWithGroups {}

// Source: com/trafi/core/model/RentalStationWithAvailabilities.java
@doc("Placeholder - details not extracted from decompiled source")
model RentalStationWithAvailabilities {}

// Source: com/trafi/core/model/SharingVehicleFilter.java
@doc("Placeholder - details not extracted from decompiled source")
model SharingVehicleFilter {}

// Source: com/trafi/core/model/VehicleSharingLocalizations.java
@doc("Placeholder - details not extracted from decompiled source")
model VehicleSharingLocalizations {}

// Source: com/trafi/core/model/RideHailingPricing.java
@doc("Placeholder - details not extracted from decompiled source")
model RideHailingPricing {}

// Source: com/trafi/core/model/RideHailingBookingStatusInfo.java
@doc("Placeholder - details not extracted from decompiled source")
model RideHailingBookingStatusInfo {}

// Source: com/trafi/core/model/OperationRestrictions.java
@doc("Placeholder - details not extracted from decompiled source")
model OperationRestrictions {}

// Source: com/trafi/core/model/RequiredAction.java
@doc("Placeholder - details not extracted from decompiled source")
model RequiredAction {}

// Source: com/trafi/core/model/SharingBookingStatusTransition.java
@doc("Placeholder - details not extracted from decompiled source")
model SharingBookingStatusTransition {}

// Source: com/trafi/core/model/FuelCard.java
@doc("Fuel card for vehicle sharing")
model FuelCard {
  title: string;
  pin: string;
}

// Source: com/trafi/core/model/BookingPrompt.java
@doc("Prompt content for a booking")
model BookingPrompt {
  content: ManualItem[];
}

// Source: com/trafi/core/model/TripPurpose.java
@doc("Placeholder - details not extracted from decompiled source")
model TripPurpose {}
