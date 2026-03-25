import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Trafi.Routes;

// Source: ahh.java — Tickets API (11 endpoints)
@tag("Tickets")
@route("/")
interface Tickets {
  // Source: ahh.java — @d06("v2/tickets")
  @doc("Get all user tickets with optional expired ticket filtering")
  @route("v2/tickets")
  @get
  getTickets(@query includeExpiredTickets: boolean):
    | Trafi.Models.TicketsResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @d06("v1/tickets/products")
  @doc("Get available ticket products for a subregion")
  @route("v1/tickets/products")
  @get
  getProducts(@query subregionId: string):
    | Trafi.Models.TicketProductResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @xra("v1/tickets/buy")
  @doc("Purchase tickets")
  @route("v1/tickets/buy")
  @post
  buyTickets(@body body: Trafi.Models.TicketBuyRequest):
    | Trafi.Models.TicketBuyResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @xra("v1/tickets/confirm")
  @doc("Confirm a pending ticket purchase after payment challenge")
  @route("v1/tickets/confirm")
  @post
  confirmPurchase(@body body: Trafi.Models.TicketConfirmRequest):
    | Trafi.Models.TicketBuyResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @ae6("/v1/tickets/cancel")
  @doc("Cancel a ticket purchase")
  @route("v1/tickets/cancel")
  @delete
  cancelPurchase(@body body: Trafi.Models.TicketCancelRequest):
    | Trafi.Models.EmptySuccessResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @xra("v2/tickets/activate")
  @doc("Activate a purchased ticket for use")
  @route("v2/tickets/activate")
  @post
  activateTicket(@body body: Trafi.Models.ActivateTicketRequest):
    | Trafi.Models.TicketsResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @xra("v1/tickets/acknowledge/shown")
  @doc("Acknowledge that tickets have been shown to the user")
  @route("v1/tickets/acknowledge/shown")
  @post
  acknowledgeShown(@body body: Trafi.Models.AcknowledgeShownRequest):
    | Trafi.Models.EmptySuccessResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @xra("v2/tickets/products/offer")
  @doc("Get personalized ticket product offers")
  @route("v2/tickets/products/offer")
  @post
  getProductsOffer(@body body: Trafi.Models.GetProductsOfferRequest):
    | Trafi.Models.GetProductsOfferResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: ahh.java — @d06("v1/tickets/ticketshop")
  @doc("Get ticket shop configuration for a subregion")
  @route("v1/tickets/ticketshop")
  @get
  getTicketShop(@query subregionId: string):
    | {}
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;

  // Source: wgh.java — @xra("/v1/tickets/products/by-route")
  @doc("Get ticket products applicable to a specific route")
  @route("v1/tickets/products/by-route")
  @post
  getTicketProductsByRoute(@body body: Trafi.Models.GetProductsByRouteRequest):
    | Trafi.Models.TicketProductResponse
    | Trafi.Models.BadRequestResponse
    | Trafi.Models.UnauthorizedResponse
    | Trafi.Models.InternalServerErrorResponse;
}
