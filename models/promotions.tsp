import "@typespec/http";

using TypeSpec.Http;

namespace Trafi.Models;

/** Response containing claimed promotions. Source: x4c.java → GetPromotionsResponse */
model GetPromotionsResponse {
  promotions?: Promotion[];
}

/** Response containing applicable promotions for a provider. Source: x4c.java → GetApplicablePromotionsResponse */
model GetApplicablePromotionsResponse {
  promotions?: Promotion[];
}

/** Promotion requirements response. Source: v76.java → PromotionRequirementsResponse */
model PromotionRequirementsResponse {
  requirements?: PromotionRequirement[];
}

/** Request to claim a promotion. Source: v76.java → PromotionClaimRequest */
model PromotionClaimRequest {
  promotionId?: string;
  code?: string;
}

/** Response from claiming a promotion. Source: v76.java → PromotionClaimResponse */
model PromotionClaimResponse {
  promotion?: Promotion;
}

/** A promotion object. */
model Promotion {
  id?: string;
  title?: string;
  description?: string;
  code?: string;
  status?: string;
  providerId?: string;
}

/** A promotion requirement. */
model PromotionRequirement {
  id?: string;
  type?: string;
  status?: string;
}

/** Response containing referrals. Source: x4c.java → GetReferralResponse */
model GetReferralResponse {
  referrals?: Referral[];
}

/** Response containing a single referral by ID. Source: x4c.java → GetReferralByIdResponse */
model GetReferralByIdResponse {
  referral?: Referral;
}

/** Response containing referral campaigns. Source: x4c.java → GetReferralCampaignResponse */
model GetReferralCampaignResponse {
  campaigns?: ReferralCampaign[];
}

/** Response containing referral redemptions. Source: x4c.java → GetReferralRedemptionResponse */
model GetReferralRedemptionResponse {
  redemptions?: ReferralRedemption[];
}

/** Request to claim a referral. Source: x4c.java → ClaimReferralRequest */
model ClaimReferralRequest {
  referralCode?: string;
}

/** Response from claiming a referral. Source: x4c.java → ClaimReferralResponse */
model ClaimReferralResponse {
  referral?: Referral;
}

/** Request to redeem a referral. Source: x4c.java → RedeemReferralRequest */
model RedeemReferralRequest {
  referralId?: string;
}

/** Response from redeeming a referral. Source: x4c.java → RedeemReferralResponse */
model RedeemReferralResponse {
  redemption?: ReferralRedemption;
}

/** A referral object. */
model Referral {
  id?: string;
  code?: string;
  campaignId?: string;
  status?: string;
}

/** A referral campaign. */
model ReferralCampaign {
  id?: string;
  title?: string;
  description?: string;
}

/** A referral redemption. */
model ReferralRedemption {
  id?: string;
  referralId?: string;
  status?: string;
}
