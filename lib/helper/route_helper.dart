import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/features/splash/screens/splash_screen.dart';

class RouteHelper {
  static const String splash = '/splash';
  static getSplashRoute({Map<String,dynamic>? notificationData}) {
    notificationData?.remove('body');

    return '$splash?notification=${jsonEncode(notificationData)}';
  }
  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen(notificationData: Get.parameters['notification'] == null ? null : jsonDecode(Get.parameters['notification']!))),
  ];

  static goPageAndHideTextField(BuildContext context, Widget page){
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    currentFocus.requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    Future.delayed(const Duration(milliseconds: 300)).then((_){
      Get.to(() => page);

    });

  }

}