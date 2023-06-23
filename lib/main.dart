import 'dart:async';

import 'package:Hilite/home/menu/settings/app_settings_screen.dart';
import 'package:Hilite/providers/calls_providers.dart';
import 'package:Hilite/utils/theme.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';
import 'app/constants.dart';
import 'app/navigation_service.dart';
import 'app/setup.dart';
import 'auth/dispache_screen.dart';
import 'auth/forgot_screen.dart';
import 'auth/welcome_screen.dart';
import 'core/locator.dart';
import 'helpers/quick_help.dart';
import 'home/coins/refill_coins_screen.dart';
import 'home/following/following_screen.dart';
import 'home/home_screen.dart';
import 'home/leaders/leaders_screen.dart';
import 'home/leaders/select_country.dart';
import 'home/live/live_preview.dart';
import 'home/menu/blocked_users_screen.dart';
import 'home/menu/get_money_screen.dart';
import 'home/menu/gifters_screen.dart';
import 'home/menu/settings/account_settings_screen.dart';
import 'home/menu/settings/connected_accounts.dart';
import 'home/menu/settings/customer_support.dart';
import 'home/menu/settings/delete_account_screen.dart';
import 'home/menu/settings/my_app_code_screen.dart';
import 'home/menu/settings/notifications_sounds_screen.dart';
import 'home/menu/settings/privacy_settings_screen.dart';
import 'home/menu/settings/qr_code_scanner.dart';
import 'home/menu/settings_screen.dart';
import 'home/menu/statistics_screen.dart';
import 'home/menu/withdraw_history_screen.dart';
import 'home/message/message_list_screen.dart';
import 'home/message/message_screen.dart';
import 'home/profile/profile_edit.dart';
import 'home/profile/profile_menu_screen.dart';
import 'home/profile/profile_screen.dart';
import 'home/profile/user_profile_screen.dart';
import 'home/reels/reels_home_screen.dart';
import 'home/search/search_creen.dart';
import 'home/web/web_url_screen.dart';
import 'models/CallsModel.dart';
import 'models/CommentsModel.dart';
import 'models/GiftSendersGlobalModel.dart';
import 'models/GiftSendersModel.dart';
import 'models/GiftsModel.dart';
import 'models/GiftsSentModel.dart';
import 'package:get/get.dart';

import 'models/HashtagsModel.dart';
import 'models/InvitedUsersModel.dart';
import 'models/LeadersModel.dart';
import 'models/MessageModel.dart';
import 'models/NotificationsModel.dart';
import 'models/PaymentsModel.dart';
import 'models/PictureModel.dart';
import 'models/PostsModel.dart';
import 'models/ReportModel.dart';
import 'models/UserModel.dart';
import 'models/WithdrawModel.dart';
import 'services/dynamic_link_service.dart';
import 'app/config.dart';

import 'home/feed/comment_post_screen.dart';
import 'home/location_screen.dart';
import 'home/menu/referral_program_screen.dart';
import 'home/notifications/notifications_screen.dart';
import 'models/LiveMessagesModel.dart';
import 'models/LiveStreamingModel.dart';
import 'models/MessageListModel.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (QuickHelp.isMobile()) {
    MobileAds.instance.initialize();
  }

  initPlatformState();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  Map<String, ParseObjectConstructor> subClassMap =
      <String, ParseObjectConstructor>{
    PictureModel.keyTableName: () => PictureModel(),
    PostsModel.keyTableName: () => PostsModel(),
    NotificationsModel.keyTableName: () => NotificationsModel(),
    MessageModel.keyTableName: () => MessageModel(),
    MessageListModel.keyTableName: () => MessageListModel(),
    CommentsModel.keyTableName: () => CommentsModel(),
    LeadersModel.keyTableName: () => LeadersModel(),
    GiftsModel.keyTableName: () => GiftsModel(),
    GiftsSentModel.keyTableName: () => GiftsSentModel(),
    LiveStreamingModel.keyTableName: () => LiveStreamingModel(),
    HashTagModel.keyTableName: () => HashTagModel(),
    LiveMessagesModel.keyTableName: () => LiveMessagesModel(),
    LiveMessagesModel.keyTableName: () => LiveMessagesModel(),
    WithdrawModel.keyTableName: () => WithdrawModel(),
    PaymentsModel.keyTableName: () => PaymentsModel(),
    InvitedUsersModel.keyTableName: () => InvitedUsersModel(),
    CallsModel.keyTableName: () => CallsModel(),
    GiftsSenderModel.keyTableName: () => GiftsSenderModel(),
    GiftsSenderGlobalModel.keyTableName: () => GiftsSenderGlobalModel(),
    ReportModel.keyTableName: () => ReportModel()
  };

  await Parse().initialize(
    Config.appId,
    Config.serverUrl,
    clientKey: Config.clientKey,
    liveQueryUrl: Config.liveQueryUrl,
    autoSendSessionId: true,
    coreStore: QuickHelp.isWebPlatform()
        ? await CoreStoreSharedPrefsImp.getInstance()
        : await CoreStoreSembastImp.getInstance(password: Config.appId),
    debug: Setup.isDebug,
    appName: Setup.appName,
    appPackageName: Setup.appPackageName,
    appVersion: Setup.appVersion,
    locale: await Devicelocale.currentLocale,
    parseUserConstructor: (username, password, email,
            {client, debug, sessionToken}) =>
        UserModel(username, password, email),
    registeredSubClassMap: subClassMap,
  );

  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CallsProvider()),
          ],
          child: EasyLocalization(
            supportedLocales: Config.languages,
            path: 'assets/translations',
            fallbackLocale: Locale(Config.defaultLanguage),
            child: App(),
          ),
        ),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

Future<void> initPlatformState() async {
  if (Setup.isDebug) {
    await Purchases.setLogLevel(LogLevel.verbose);
  }

  PurchasesConfiguration? configuration;

  if (QuickHelp.isAndroidPlatform()) {
    configuration = PurchasesConfiguration(Config.publicGoogleSdkKey);
  } else if (QuickHelp.isIOSPlatform()) {
    configuration = PurchasesConfiguration(Config.publicIosSdkKey);
  }
  await Purchases.configure(configuration!);
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late SharedPreferences preferences;

  @override
  void initState() {
    if (!QuickHelp.isWebPlatform()) {
      context.read<CallsProvider>().connectAgoraRtm();
    }

    Future.delayed(Duration(seconds: 2), () {
      DynamicLinkService().listenDynamicLink(context);
    });

    initSharedPref();

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Setup.appName,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      navigatorKey: NavigationService.navigatorKey,
      locale: context.locale,
      routes: {
        //Before Login
        WelcomeScreen.route: (_) => WelcomeScreen(),
        ForgotScreen.route: (_) => ForgotScreen(),

        // Home and tabs
        HomeScreen.route: (_) => HomeScreen(
              preferences: preferences,
            ),
        FollowingScreen.route: (_) => FollowingScreen(
              preferences: preferences,
            ),
        NotificationsScreen.route: (_) => NotificationsScreen(
              preferences: preferences,
            ),
        LocationScreen.route: (_) => LocationScreen(),
        SearchPage.route: (_) => SearchPage(
              preferences: preferences,
            ),
        ReelsHomeScreen.route: (_) => ReelsHomeScreen(
              preferences: preferences,
            ),

        //Profile
        ProfileMenuScreen.route: (_) => ProfileMenuScreen(
              preferences: preferences,
            ),
        ProfileScreen.route: (_) => ProfileScreen(),
        ProfileEdit.route: (_) => ProfileEdit(),
        UserProfileScreen.route: (_) => UserProfileScreen(),

        //Chat
        MessagesListScreen.route: (_) => MessagesListScreen(
              preferences: preferences,
            ),
        MessageScreen.route: (_) => MessageScreen(
              preferences: preferences,
            ),

        //Feed
        CommentPostScreen.route: (_) => CommentPostScreen(),

        //LiveStreaming
        LivePreviewScreen.route: (_) => LivePreviewScreen(),
        LivePreviewScreen.route: (_) => LivePreviewScreen(),

        //Leaders
        LeadersPage.route: (_) => LeadersPage(),

        //Settings
        MyAppCodeScreen.route: (_) => MyAppCodeScreen(),
        AccountSettingsScreen.route: (_) => AccountSettingsScreen(),
        ConnectedAccountsScreen.route: (_) => ConnectedAccountsScreen(),
        PrivacySettingsScreen.route: (_) => PrivacySettingsScreen(),
        AppSettingsScreen.route: (_) => AppSettingsScreen(),
        NotificationsSoundsScreen.route: (_) => NotificationsSoundsScreen(),
        CustomerSupportScreen.route: (_) => CustomerSupportScreen(),
        DeleteAccountPage.route: (_) => DeleteAccountPage(),
        QRViewScanner.route: (_) => QRViewScanner(),
        SelectCountryScreen.route: (_) => SelectCountryScreen(),

        // Menu
        GiftersScreen.route: (_) => GiftersScreen(),
        StatisticsScreen.route: (_) => StatisticsScreen(),
        ReferralScreen.route: (_) => ReferralScreen(),
        BlockedUsersScreen.route: (_) => BlockedUsersScreen(),
        RefillCoinsScreen.route: (_) => RefillCoinsScreen(),
        GetMoneyScreen.route: (_) => GetMoneyScreen(
              preferences: preferences,
            ),
        SettingsScreen.route: (_) => SettingsScreen(),
        WithdrawHistoryScreen.route: (_) => WithdrawHistoryScreen(),

        // Logged user or not
        QuickHelp.pageTypeTerms: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeTerms),
        QuickHelp.pageTypePrivacy: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypePrivacy),
        QuickHelp.pageTypeHelpCenter: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeHelpCenter),
        QuickHelp.pageTypeOpenSource: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeOpenSource),
        QuickHelp.pageTypeSafety: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeSafety),
        QuickHelp.pageTypeCommunity: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeCommunity),
        QuickHelp.pageTypeInstructions: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeInstructions),
        QuickHelp.pageTypeSupport: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeSupport),
        QuickHelp.pageTypeCashOut: (_) =>
            WebViewScreen(pageType: QuickHelp.pageTypeCashOut),
      },
      home: UpgradeAlert(
        upgrader: Upgrader(
          debugDisplayAlways: false,
          debugLogging: Setup.isDebug,
          showIgnore: false,
          showLater: false,
          canDismissDialog: false,
          shouldPopScope: () => false,
          durationUntilAlertAgain: Duration(seconds: 10),
          minAppVersion: Setup.appVersion,
        ),
        child: FutureBuilder<UserModel?>(
            future: QuickHelp.getUserAwait(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Scaffold(
                    body: QuickHelp.appLoadingLogo(),
                  );
                default:
                  if (snapshot.hasData) {
                    return DispacheScreen(
                      preferences: preferences,
                      currentUser: snapshot.data,
                    );
                  } else {
                    logoutUserPurchase();

                    return WelcomeScreen();
                  }
              }
            }),
      ),
    );
  }

  logoutUserPurchase() async {
    if (!await Purchases.isAnonymous) {
      await Purchases.logOut().then((value) => print("purchase logout"));
    }
  }

  initSharedPref() async {
    preferences = await SharedPreferences.getInstance();
    Constants.queryParseConfig(preferences);
  }
}
