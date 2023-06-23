import '../app/config.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:easy_localization/easy_localization.dart';

import 'constants.dart';

class Setup {
  static final bool isDebug = kDebugMode;

  static String appName = Config.appName;
  static String appPackageName = Constants.appPackageName();
  static String appVersion = Config.appVersion;
  static String bio = "welcome_bio".tr(namedArgs: {"app_name": appName});
  static final List<String> allowedCountries =
      []; //['FR', 'CA', 'US', 'AO', 'BR'];
  static final int verificationCodeDigits = 6;

  // Social login= Config.appName
  static final bool isPhoneLoginEnabled = false;
  static final bool isFacebookLoginEnabled = true;
  static final bool isGoogleLoginEnabled = true;
  static final bool isAppleLoginEnabled = true;

  // App config
  static final bool isCallsEnabled = true;
  static final String streamingProviderType = 'agora';
  static final String streamingProviderKey = 'd50a70140309452f96f6b66a1422da03';

  static final bool isWithdrawIbanEnabled = false;
  static final bool isWithdrawPayoneerEnabled = false;
  static final bool isWithdrawPaypalEnabled = true;
  static final bool isWithdrawUSDTlEnabled = true;

  // Additional Payments method, Google Play and Apple Pay are enabled by default
  static final bool isStripePaymentsEnabled = false;
  static final bool isPayPalPaymentsEnabled = true;

  // User fields
  static final int welcomeCredit = 10;
  static final int minimumAgeToRegister = 18;
  static final int maximumAgeToRegister = 99;
  static final int? maxDistanceBetweenUsers = 80;

  // Live Streaming and Calls
  static final int minimumDiamondsToPopular = 1000;
  static final int callWaitingDuration = 30; // seconds

  //Withdraw calculations
  static final int diamondsEarnPercent = 30; //Percent to give the streamer.
  static final int withDrawPercent = 30; //Percent to give the streamer.
  static final int agencyPercent = 5; //Percent to give the agency.
  static final int diamondsNeededToRedeem =
      5000; // Minimum diamonds needed to redeem

  // Calls cost
  static final int coinsNeededForVideoCallPerMinute =
      100; //Coins per minute needed to make video call
  static final int coinsNeededForVoiceCallPerMinute =
      50; //Coins per minute needed to make Voice call

  //Leaders
  static final int diamondsNeededForLeaders = 1000;

  //Lives
  static final double maxDistanceToNearBy = 500; //In Km
  static final int maxSecondsToShowBigGift = 5; //In seconds

  // Feed
  static final int coinsNeededToForExclusivePost = 100;

  // Ads Config
  static final bool isBannerAdsOnHomeReelsEnabled = false;
}
