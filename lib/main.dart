import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import './screens/SplashScreen.dart';
import './services/AuthService.dart';
import './services/CategoryService.dart';
import './services/QuestionService.dart';
import './services/QuizHistoryService.dart';
import './services/QuizService.dart';
import './services/SettingService.dart';
import './services/userDBService.dart';
import './store/AppStore.dart';
import './utils/colors.dart';
import './utils/constants.dart';

AppStore appStore = AppStore();

FirebaseFirestore db = FirebaseFirestore.instance;

AuthService authService = AuthService();
UserDBService userDBService = UserDBService();
CategoryService categoryService = CategoryService();
QuestionService questionService = QuestionService();
QuizService quizService = QuizService();
QuizHistoryService quizHistoryService = QuizHistoryService();
AppSettingService appSettingService = AppSettingService();

bool bannerReady = false;
bool interstitialReady = false;
bool rewarded = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    MobileAds.instance.initialize();
  });

  defaultRadius = 12.0;
  defaultAppButtonRadius = 12.0;
  await initialize(); //Shared Preferences

  setOrientationPortrait();

  appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN));
  if (appStore.isLoggedIn) {
    appStore.setUserId(getStringAsync(USER_ID));
    appStore.setName(getStringAsync(USER_DISPLAY_NAME));
    appStore.setUserEmail(getStringAsync(USER_EMAIL));
    appStore.setProfileImage(getStringAsync(USER_PHOTO_URL));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: mAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        scaffoldBackgroundColor: scaffoldColor,
      ),
      home: SplashScreen(),
    );
  }
}
