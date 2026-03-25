import "@typespec/http";

using TypeSpec.Http;

namespace Trafi.Models;

/** Request to save a push notification token. Source: uca.java → SavePushTokenRequest */
model SavePushTokenRequest {
  token?: string;
  platform?: string;
}

/** Response containing active notification IDs. Source: yca.java → GetActiveNotificationIdsResponse */
model GetActiveNotificationIdsResponse {
  notificationIds?: string[];
}

/** Response containing full notification objects. Source: yca.java → GetNotificationsResponse */
model GetNotificationsResponse {
  notifications?: Notification[];
}

/** A notification object. */
model Notification {
  id?: string;
  title?: string;
  body?: string;
  type?: string;
  createdAt?: int64;
}
