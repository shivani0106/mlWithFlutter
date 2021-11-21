import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funwithml/database/app_preferences.dart';
import 'package:funwithml/view/home/home_view.dart';

class SplashViewModel with ChangeNotifier {
  bool isStart = false;

  BuildContext? mContext;

  late String _deviceToken;
  bool startSession = false;
  String? currentSessionId;
  AppPreferences _appPreferences = AppPreferences();

  // redirectToSignInView(BuildContext context) {
  //   Navigator.pushReplacement(
  //       context, CupertinoPageRoute(builder: (context) => SignInView()));
  // }

  redirectToHomeView(BuildContext context) {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => HomeView()));
  }
/*
  void getActiveSession() async {
    await _appPreferences.getUserDetails().then((value) {
      if (value != null) {
        redirectToHomeView(mContext!);
      } else {
        redirectToSignInView(mContext!);
      }
    });
    notifyListeners();
  }*/
}
