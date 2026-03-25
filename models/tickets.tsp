import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/Ticket.java — ALL 33 @yi7 fields verified 2026-03-25
@example(#{
  id: "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  providerId: "vilnius-public-transport",
  productId: "single-ride-30",
  title: "Single ride 30 min",
  originalTitle: "Vienkartinis 30 min",
  iconType: #{ value: Trafi.Enums.IconTypeValue.BUS },
  status: Trafi.Enums.TicketStatus.ACTIVE,
  expiryPeriodMillis: 1800000,
  isRefundable: false,
  upgrades: #{},
  allowedActions: #[],
  validFrom: 1711360000000,
  validTo: 1711361800000,
  purchasedAt: 1711359900000
})
@doc("A transit ticket purchased by the user")
model Ticket {
  // Required fields
  @doc("Unique ticket identifier")
  id: string;
  @doc("ID of the transit provider (e.g., 'vilnius-public-transport')")
  providerId: string;
  productId: string;
  title: string;
  originalTitle: string;
  iconType: IconType;
  @doc("Current status of the ticket")
  status: Trafi.Enums.TicketStatus;
  @doc("Duration in milliseconds for which the ticket is valid after activation")
  expiryPeriodMillis: int64;
  isRefundable: boolean;
  upgrades: TicketUpgrades;
  allowedActions: TicketAllowedAction[];

  // Nullable fields
  metadata?: Record<string>;
  partId?: string;
  subtitle?: string;
  information?: string;
  description?: string;
  additionalInfo?: string;
  @doc("Timestamp in milliseconds when the ticket was purchased. Value -62135596800000 is a sentinel for Go time.Time zero")
  purchasedAt?: int64;
  @doc("Timestamp in milliseconds when the ticket becomes valid")
  validFrom?: int64;
  @doc("Timestamp in milliseconds when the ticket expires")
  validTo?: int64;
  renewsOn?: int64;
  refundedAt?: int64;
  departureStop?: string;
  @doc("QR code data for ticket validation")
  qrCode?: string;
  html?: string;
  priceDetails?: string;
  meta?: string;
  @doc("Activation product details including remaining count")
  product?: TicketActivationProduct;
  customerCode?: string;
  availableOn?: AvailableOn;
  isForBoardingOnly?: boolean;
  customIntegrationData?: DynamicData;
  messages?: InfoMessage[];
}

// Source: com/trafi/core/model/TicketsResponse.java line 62
@example(#{
  currentTime: 1711360500000,
  tickets: #[],
  ticketSubscriptions: #[],
  providers: #[]
})
@doc("Response containing user tickets, subscriptions, and providers")
model TicketsResponse {
  @doc("Server time in milliseconds")
  currentTime: int64;
  tickets: Ticket[];
  ticketSubscriptions: TicketSubscription[];
  providers: Provider[];
}

// Source: com/trafi/core/model/TicketSubscription.java
@doc("A recurring ticket subscription")
model TicketSubscription {
  id: string;
  status: Trafi.Enums.TicketSubscriptionStatus;
  currentTime: int64;
  currentTicket?: Ticket;
  expiresAt?: int64;
  renewsOn?: int64;
}

// Source: com/trafi/core/model/TicketBuyRequest.java
@doc("Request to purchase tickets")
model TicketBuyRequest {
  items: TicketBuyRequestItem[];
  idempotencyKey?: string;
  braintreeDeviceData?: string;
  paymentMethodId?: string;
  tripPurposeId?: string;
  promotionId?: string;
}

// Source: com/trafi/core/model/TicketBuyRequestItem.java
@doc("Item in a ticket buy request")
model TicketBuyRequestItem {
  productId: string;
  validTicketCount: int32;
  buyTicketCount: int32;
  providerId?: string;
  userOfferContext?: string;
  validFromMillis?: int64;
  validFromOffset?: int64;
  departureStopId?: string;
  travelCardId?: string;
  ticketId?: string;
  passengerInfo?: PassengerInfo;
  booleanArgumentSelections?: BooleanArgumentSelection[];
  autoRenewArgumentSelection?: AutoRenewArgumentSelection;
}

// Source: com/trafi/core/model/TicketBuyResponse.java
@doc("Response from ticket purchase containing updated ticket list")
model TicketBuyResponse {
  currentTime: int64;
  tickets: Ticket[];
  boughtTickets: Ticket[];
  providers: Provider[];
  provider?: Provider;
  challenge?: PaymentChallenge;
}

// Source: com/trafi/core/model/ActivateTicketRequest.java
@doc("Request to activate a purchased ticket")
model ActivateTicketRequest {
  @doc("ID of the ticket to activate")
  ticketId: string;
  @doc("Number of activations")
  count: int32;
  departureStopId?: string;
  idempotencyKey?: string;
  providerId?: string;
  travelCardId?: string;
  stopArgumentSelections?: StopArgumentSelection[];
  dateArgumentSelections?: DateArgumentSelection[];
}

// Source: com/trafi/core/model/TicketCancelRequest.java
@doc("Request to cancel a ticket purchase")
model TicketCancelRequest {
  purchaseSessionId: string;
}

// Source: com/trafi/core/model/TicketConfirmRequest.java
@doc("Request to confirm a ticket purchase after payment challenge")
model TicketConfirmRequest {
  purchaseSessionId: string;
  idempotencyKey?: string;
}

// Source: com/trafi/core/model/AcknowledgeShownRequest.java
@doc("Request to acknowledge shown tickets")
model AcknowledgeShownRequest {
  ticketWithPartIds?: TicketWithPartId[];
}

// Source: com/trafi/core/model/TicketWithPartId.java
@doc("Ticket identifier with part ID")
model TicketWithPartId {
  ticketId?: string;
  providerId?: string;
  ticketPartId?: string;
}

// Source: com/trafi/core/model/StopArgumentSelection.java
@doc("Stop argument selection for ticket activation")
model StopArgumentSelection {
  argumentId: string;
  stopId: string;
}

// Source: com/trafi/core/model/DateArgumentSelection.java
@doc("Date argument selection for ticket activation")
model DateArgumentSelection {
  argumentId: string;
  validFromOffset: int64;
}

// Source: com/trafi/core/model/TicketProductResponse.java
@doc("Response containing available ticket products organized by category")
model TicketProductResponse {
  providers: Provider[];
  categories: TicketProductCategory[];
  popular: TicketProductGroup[];
  other: TicketProductGroup[];
  ticketSubscriptions: TicketProductGroup[];
  ticketSubscriptionCategories: TicketProductCategory[];
  ticketShopSettings: TicketShopSettings;
  provider?: Provider;
  supportsGettingTicketsByRoute?: boolean;
  subregionId?: string;
}

// Source: com/trafi/core/model/TicketProductCategory.java
@doc("Category grouping ticket products")
model TicketProductCategory {
  id: string;
  name: string;
  originalName: string;
  iconType: IconType;
  groups: TicketProductGroup[];
  messages: InfoMessage[];
  description?: string;
  providerId?: string;
}

// Source: com/trafi/core/model/TicketProductGroup.java
@doc("Group of related ticket products")
model TicketProductGroup {
  id: string;
  name: string;
  originalName: string;
  description: string;
  iconType: IconType;
  isPopular: boolean;
  isUnavailable: boolean;
  products: TicketProduct[];
  subtitle?: string;
  suffix?: string;
  resources?: ProductGroupResources;
  isForBoardingOnly?: boolean;
  providerId?: string;
  savings?: string;
  shortName?: string;
  travelTime?: TravelTime;
}

// Source: com/trafi/core/model/TicketActivationProduct.java
@doc("Product details for an activated ticket")
model TicketActivationProduct {
  name: string;
  description: string;
  properties: TicketProductProperty[];
  arguments?: TicketProductArguments;
  @doc("Number of remaining activations")
  remainingCount?: int32;
}

// Source: com/trafi/core/model/TicketProductProperty.java
@doc("Property of a ticket product")
model TicketProductProperty {
  valueId: string;
  id: string;
  name: string;
  value: string;
  description: string;
  additionalInfo?: string;
}

// Source: com/trafi/core/model/TicketProductArguments.java
@doc("Arguments for ticket product configuration")
model TicketProductArguments {
  booleanArguments: BooleanArgument[];
  stopArguments: TicketProductStopArgument[];
  dateArguments: TicketProductDateArgument[];
  stopArgument?: TicketProductStopArgument;
  dateArgument?: TicketProductDateArgument;
  activationArgument?: TicketProductActivationArgument;
  passengerInfoArgument?: TicketProductPassengerInfoArgument;
  autoRenewArgument?: AutoRenewArgument;
}

// Source: com/trafi/core/model/TicketShopSettings.java
@doc("Ticket shop configuration settings")
model TicketShopSettings {
  supportContacts: SupportContact[];
}

// Source: com/trafi/core/model/GetProductsOfferRequest.java
@doc("Request to get product offers")
model GetProductsOfferRequest {
  providerId: string;
  productOfferParameters: ProductOfferParameters[];
}

// Source: com/trafi/core/model/GetProductsOfferResponse.java
@doc("Response containing product offers")
model GetProductsOfferResponse {
  products: TicketProduct[];
}

// Source: com/trafi/core/model/GetProductsByRouteRequest.java
@doc("Request to get ticket products for a specific route")
model GetProductsByRouteRequest {
  startTimeMillis: int64;
  providerIds?: string[];
  startStop?: RouteStop;
  endStop?: RouteStop;
  returnTimeMillis?: int64;
  passengerCount?: int32;
  filters?: TicketProductPropertyFilter[];
}

// Placeholder models referenced by ticket types
@doc("Placeholder - details not extracted from decompiled source")
model PassengerInfo {}
@doc("Placeholder - details not extracted from decompiled source")
model BooleanArgumentSelection {}
@doc("Placeholder - details not extracted from decompiled source")
model AutoRenewArgumentSelection {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketProduct {}
@doc("Placeholder - details not extracted from decompiled source")
model ProductGroupResources {}
@doc("Placeholder - details not extracted from decompiled source")
model TravelTime {}
@doc("Placeholder - details not extracted from decompiled source")
model BooleanArgument {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketProductStopArgument {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketProductDateArgument {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketProductActivationArgument {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketProductPassengerInfoArgument {}
@doc("Placeholder - details not extracted from decompiled source")
model AutoRenewArgument {}
@doc("Placeholder - details not extracted from decompiled source")
model ProductOfferParameters {}
@doc("Placeholder - details not extracted from decompiled source")
model RouteStop {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketProductPropertyFilter {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketUpgrades {}
@doc("Placeholder - details not extracted from decompiled source")
model TicketAllowedAction {}
@doc("Placeholder - details not extracted from decompiled source")
model AvailableOn {}
@doc("Placeholder - details not extracted from decompiled source")
model DynamicData {}
