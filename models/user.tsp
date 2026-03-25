import "@typespec/http";
using TypeSpec.Http;

namespace Trafi.Models;

// Source: com/trafi/core/model/User.java
@doc("Authenticated user profile with accounts, payments, and settings")
model User {
  @doc("Unique user identifier (UUID)")
  id: string;
  profile: Profile;
  attributes: UserAttributes;
  providerAccounts: ProviderAccount[];
  drivingLicence: DrivingLicence;
  identity: Identity;
  paymentMethods: PaymentMethod[];
  requirements: UserRequirements;
  memberships: Membership[];
  createdAt: string;
  providerAccountIntents: ProviderAccountIntent[];
  restrictedProviders: RestrictedProvider[];
  settings: UserSettings;
  phoneNumber?: string;
}

// Source: com/trafi/core/model/Profile.java
@example(#{
  gender: Trafi.Enums.Gender.UNSPECIFIED,
  firstName: "Jonas",
  lastName: "Jonaitis",
  email: "jonas@example.com"
})
@doc("User profile information")
model Profile {
  gender: Trafi.Enums.Gender;
  firstName?: string;
  lastName?: string;
  displayName?: string;
  email?: string;
  addressLineOne?: string;
  addressLineTwo?: string;
  city?: string;
  administrativeDivision?: string;
  country?: string;
  birthDate?: string;
  ageRange?: string;
  postCode?: string;
  nationality?: string;
  metadata?: Record<string>;
}

// Source: com/trafi/core/model/ProviderAccount.java
@doc("User's account with a transport provider")
model ProviderAccount {
  id: string;
  type: Trafi.Enums.ProviderAccountType;
  externalUserId: string;
  isLevel3?: boolean;
  profile?: Profile;
}

// Source: com/trafi/core/model/PaymentMethod.java
@doc("A payment method registered to the user")
model PaymentMethod {
  id: string;
  type: Trafi.Enums.PaymentMethodType;
  @doc("Whether this is the default payment method")
  isDefault: boolean;
  shouldRefreshAfterPurchase: boolean;
  canNotBeDeleted: boolean;
  tripPurposes: TripPurpose[];
  creditCard?: CreditCardInfo;
  directDebit?: DirectDebitInfo;
  paypal?: Paypal;
  prePay?: PrePay;
  digitalWallet?: DigitalWalletInfo;
  mobilityBudget?: MobilityBudget;
}

// Source: com/trafi/core/model/UserSettings.java
@doc("User application settings")
model UserSettings {
  language?: Language;
}

// Source: com/trafi/core/model/UserAttributes.java
@doc("User attributes for identity verification")
model UserAttributes {
  name?: UserAttributePersonName;
  birthDate?: UserAttributeString;
  gender?: UserAttributeGender;
  address?: UserAttributeAddress;
  email?: UserAttributeString;
  nationality?: UserAttributeString;
}

// Source: com/trafi/core/model/Identity.java
@doc("User identity verification status")
model Identity {
  verificationStatus: Trafi.Enums.VerificationStatus;
  verificationMessageKey?: string;
  verificationFallbackMessage?: string;
}

// Source: com/trafi/core/model/DrivingLicence.java
@doc("User's driving licence information")
model DrivingLicence {
  categories: DrivingLicenceCategory[];
  verificationStatus: Trafi.Enums.VerificationStatus;
  licenceNumber?: string;
  issuedAt?: string;
  expiresAt?: string;
}

// Source: com/trafi/core/model/Membership.java
@doc("User's membership with a provider")
model Membership {
  type: Trafi.Enums.MembershipType;
  number: string;
  pin?: string;
  customerNumber?: string;
}

// Placeholder models referenced by User
@doc("Placeholder - details not extracted from decompiled source")
model UserRequirements {}
@doc("Placeholder - details not extracted from decompiled source")
model ProviderAccountIntent {}
@doc("Placeholder - details not extracted from decompiled source")
model RestrictedProvider {}
@doc("Placeholder - details not extracted from decompiled source")
model Language {}
@doc("Placeholder - details not extracted from decompiled source")
model UserAttributePersonName {}
@doc("Placeholder - details not extracted from decompiled source")
model UserAttributeString {}
@doc("Placeholder - details not extracted from decompiled source")
model UserAttributeGender {}
@doc("Placeholder - details not extracted from decompiled source")
model UserAttributeAddress {}
@doc("Placeholder - details not extracted from decompiled source")
model DrivingLicenceCategory {}
@doc("Placeholder - details not extracted from decompiled source")
model CreditCardInfo {}
@doc("Placeholder - details not extracted from decompiled source")
model DirectDebitInfo {}
@doc("Placeholder - details not extracted from decompiled source")
model Paypal {}
@doc("Placeholder - details not extracted from decompiled source")
model PrePay {}
@doc("Placeholder - details not extracted from decompiled source")
model DigitalWalletInfo {}
@doc("Placeholder - details not extracted from decompiled source")
model MobilityBudget {}
