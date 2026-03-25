import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Trafi.Routes;

using Trafi.Models;

/**
 * Promotions API — Source: x4c.java, v76.java
 * Manages promotions, referrals, and referral campaigns.
 */
@tag("Promotions")
interface Promotions {
  /** Get claimed promotions. Source: x4c.java m83759a @d06 */
  @route("v1/promotions/claimed")
  @get
  getClaimedPromotions(): GetPromotionsResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get applicable promotions for a provider. Source: x4c.java m83760b @d06 */
  @route("v1/promotions/applicable")
  @get
  getApplicablePromotions(@query providerId?: string): GetApplicablePromotionsResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get promotion requirements. Source: v76.java m79566a @d06 */
  @route("v1/promotions/requirements")
  @get
  getPromotionRequirements(): PromotionRequirementsResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Claim a promotion. Source: v76.java m79567b @xra */
  @route("v1/promotions/claim")
  @post
  claimPromotion(@body body: PromotionClaimRequest): PromotionClaimResponse | Trafi.Models.BadRequestResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get all referrals. Source: x4c.java m83763e @d06 */
  @route("v1/promotions/referrals")
  @get
  getReferrals(): GetReferralResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get a referral by ID. Source: x4c.java m83765g @d06 */
  @route("v1/promotions/referrals/{id}")
  @get
  getReferralById(@path id: string): GetReferralByIdResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.NotFoundResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get referral campaigns. Source: x4c.java m83762d @d06 */
  @route("v1/promotions/referrals/campaigns")
  @get
  getReferralCampaigns(): GetReferralCampaignResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Get referral redemptions. Source: x4c.java m83761c @d06 */
  @route("v1/promotions/referrals/redemptions")
  @get
  getReferralRedemptions(): GetReferralRedemptionResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Claim a referral. Source: x4c.java m83764f @xra */
  @route("v1/promotions/referrals/claim")
  @post
  claimReferral(@body body: ClaimReferralRequest): ClaimReferralResponse | Trafi.Models.BadRequestResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;

  /** Redeem a referral. Source: x4c.java m83766h @xra */
  @route("v1/promotions/referrals/redemptions")
  @post
  redeemReferral(@body body: RedeemReferralRequest): RedeemReferralResponse | Trafi.Models.BadRequestResponse | Trafi.Models.UnauthorizedResponse | Trafi.Models.InternalServerErrorResponse;
}
