import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Trafi.Routes;

using Trafi.Models;

/**
 * Notifications API — Source: uca.java, yca.java
 * Manages push notification tokens and retrieves notifications.
 */
@tag("Notifications")
interface Notifications {
  /** Save push notification token. Source: uca.java m77808a @xra */
  @route("v1/notifications")
  @post
  savePushToken(@body body: SavePushTokenRequest): void | Trafi.Models.BadRequestResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get active notification IDs. Source: yca.java m86824a @d06 */
  @route("v1/notifications/active")
  @get
  getActiveNotifications(@query acceptedTermKeys?: string): GetActiveNotificationIdsResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get notifications by IDs. Source: yca.java m86825b @d06 */
  @route("v1/notifications")
  @get
  getNotifications(@query ids?: string): GetNotificationsResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;
}
