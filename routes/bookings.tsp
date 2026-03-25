import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: q11.java — Bookings API (4 endpoints)
@tag("Bookings")
@route("/")
interface Bookings {
  // Source: q11.java — @d06("v2/bookings")
  @doc("Get all active bookings including tickets, sharing, rental, and ride-hailing")
  @route("v2/bookings")
  @get
  getBookings():
    | Trafi.Models.BookingsResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Note: Individual booking endpoints (sharing, ridehailing, rental) are
  // also defined in q11.java but listed under OnDemand interface to avoid duplication.
  // See routes/ondemand.tsp for:
  //   GET v1/ondemand/sharing/bookings/{bookingId}
  //   GET v1/ondemand/ridehailing/bookings/{bookingId}
  //   GET v1/ondemand/rental/bookings/{bookingId}
}
