import 'dart:ui';

import '../app/constants.dart';
import '../app/setup.dart';

import 'constants.dart';

class Config {
  static const String packageNameAndroid = "com.livestream.rossgram";
  static const String packageNameiOS = "com.livestream.rossgram";
  static const String iosAppStoreId = "1631705048";
  static final String appName = "Hilite";
  static final String appVersion = "1.3.5";
  static final String companyName = "Hilite app";
  static final String appOrCompanyUrl = "https://rosslive.belancer.by/";
  static final String initialCountry = 'US'; // United States

  static final String serverUrl = "https://parseapi.back4app.com/";
  static final String liveQueryUrl = "wss://hilite.b4a.io/";
  static final String appId = "iox9VsDZsWp5R8OCW1wZ8Y6G1F8Usj6HX5YM5Xlj";
  static final String clientKey = "27scWIMjV5fST5nxBfJ7FLotmR5VVB3KC9xftaIW";

  static final String pushGcm = "95114049968";
  static final String webPushCertificate =
      "BCsaRAkUVV8JpitKLK_dWzEz9wYDYyxQQrMo15MYQdrtQPZHIO_yjEokQG0NMFCmQr0Y-SnFzUj4NbBnGH8qEPg";

  // User support objectId
  static final String supportId = "WVp6hr1iTX";

  // Play Store and App Store public keys
  static final String publicGoogleSdkKey = "goog_XgJwibwSHuMJUMGdAuUNlLDEanp";
  static final String publicIosSdkKey = "_";

  // Languages
  static String defaultLanguage = "en"; // English is default language.
  static List<Locale> languages = [
    Locale(defaultLanguage),
    //Locale('pt'),
    //Locale('fr')
  ];

  // Dynamic link
  static const String inviteSuffix = "invitee";
  static const String uriPrefix = "https://rosslive.page.link";
  static const String link = "https://rosslive.page.link";

  // Android Admob ad
  static const String admobAndroidOpenAppAd =
      "ca-app-pub-3285903611547029/5560407341";
  static const String admobAndroidHomeBannerAd =
      "ca-app-pub-3285903611547029/6127343278";
  static const String admobAndroidFeedNativeAd =
      "ca-app-pub-3285903611547029/1109437422";
  static const String admobAndroidChatListBannerAd =
      "ca-app-pub-3285903611547029/3501179930";
  static const String admobAndroidLiveBannerAd =
      "ca-app-pub-3285903611547029/8179872141";
  static const String admobAndroidFeedBannerAd =
      "ca-app-pub-3285903611547029/9198522887";

  // iOS Admob ad
  static const String admobIOSOpenAppAd =
      "ca-app-pub-1084112649181796/632434508";
  static const String admobIOSHomeBannerAd =
      "ca-app-pub-1084112649181796/114347057";
  static const String admobIOSFeedNativeAd =
      "ca-app-pub-1084112649181796/7224533806";
  static const String admobIOSChatListBannerAd =
      "ca-app-pub-1084112649181796/58153458";
  static const String admobIOSLiveBannerAd =
      "ca-app-pub-1084112649181796/80953539063";
  static const String admobIOSFeedBannerAd =
      "ca-app-pub-1084112649181796/69053535815";

  // Web links for help, privacy policy and terms of use.
  static final String helpCenterUrl = "https://rosslive.belancer.by/";
  static final String privacyPolicyUrl =
      "https://rosslive.belancer.by/Privacy.html";
  static final String termsOfUseUrl = "https://rosslive.belancer.by/Terms.html";
  static final String termsOfUseInAppUrl =
      "https://rosslive.belancer.by/Terms.html";
  static final String dataSafetyUrl = "https://rosslive.belancer.by";
  static final String openSourceUrl = "https://rosslive.belancer.by";
  static final String instructionsUrl = "https://rosslive.belancer.by";
  static final String cashOutUrl = "https://rosslive.belancer.by";
  static final String supportUrl = "https://rosslive.belancer.by";

  // Google Play and Apple Pay In-app Purchases IDs
  static final String credit100 = "ross.100.credits";
  static final String credit200 = "ross.200.credits";
  static final String credit500 = "ross.500.credits";
  static final String credit1000 = "ross.1000.credits";
  static final String credit2100 = "ross.2100.credits";
  static final String credit5250 = "ross.5250.credits";
  static final String credit10500 = "ross.10500.credits";
}
