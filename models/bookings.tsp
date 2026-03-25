import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/BookingsResponse.java — verified from HAR + decompiled
@example(#{
  sharingBookings: #[],
  rentalBookings: #[],
  rideHailingBookings: #[],
  activeTickets: #[],
  ticketSubscriptions: #[],
  currentTime: 1711360500000,
  errors: #[]
})
@doc("Aggregated response containing all active bookings across transport modes")
model BookingsResponse {
  sharingBookings: SharingBooking[];
  rentalBookings: RentalBooking[];
  rideHailingBookings: RideHailingBooking[];
  @doc("Currently active transit tickets grouped by provider")
  activeTickets: ActiveTickets[];
  ticketSubscriptions: TicketSubscription[];
  @doc("Server time in milliseconds")
  currentTime: int64;
  @doc("Any errors encountered while fetching bookings from providers")
  errors: ApiError[];
}

// Source: com/trafi/core/model/ActiveTickets.java
@example(#{
  currentTime: 1711360500000,
  providerId: "vilnius-public-transport",
  provider: #{ id: "vilnius-public-transport", name: "Vilniaus viesasis transportas", color: "#009639", transportIcon: "bus", wheelchairAccessible: false, supportContacts: #[], features: #{}, properties: #[] },
  tickets: #[]
})
@doc("Active tickets for a specific transit provider")
model ActiveTickets {
  currentTime: int64;
  providerId: string;
  provider: Provider;
  @doc("List of currently active tickets for this provider")
  tickets: Ticket[];
}
