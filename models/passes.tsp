import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/Pass.java
@doc("A mobility pass providing discounts")
model Pass {
  @doc("Timestamp in milliseconds when the pass expires")
  validTo: int64;
  details: PassesDetails;
  id?: string;
  productCode?: string;
  providerId?: string;
  properties?: PassesProperty[];
}

// Source: com/trafi/core/model/PassesConfig.java
@doc("Passes feature configuration")
model PassesConfig {
  @doc("Whether the passes feature is enabled")
  isEnabled?: boolean;
}

// Source: com/trafi/core/model/PassesDetails.java
@doc("Pass details including discount information")
model PassesDetails {
  discountPercentage?: float64;
}

// Source: com/trafi/core/model/PassesProperty.java
@doc("A key-value property of a pass")
model PassesProperty {
  id?: string;
  value?: string;
}

// Source: com/trafi/core/model/GetUserActivePassesResponse.java
@doc("Response containing user's active passes")
model GetUserActivePassesResponse {
  passes?: Pass[];
}

// Source: com/trafi/core/model/BuyPassResponse.java
@doc("Response from purchasing a pass")
model BuyPassResponse {
  boughtPass?: Pass;
  challenge?: PaymentChallenge;
}

// Source: com/trafi/core/model/BuyPassRequest.java
@doc("Request to purchase a pass")
model BuyPassRequest {
  providerId?: string;
  productId?: string;
  paymentMethodId?: string;
  promotionId?: string;
  braintreeDeviceData?: string;
}

// Source: com/trafi/core/model/CancelPassRequest.java
@doc("Request to cancel a pass purchase")
model CancelPassRequest {
  purchaseSessionId: string;
}

// Source: com/trafi/core/model/ConfirmPassRequest.java
@doc("Request to confirm a pass purchase after payment challenge")
model ConfirmPassRequest {
  purchaseSessionId?: string;
}
