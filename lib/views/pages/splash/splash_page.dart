import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nvp_test/services/auth_service.dart';
import 'package:nvp_test/services/notification_service.dart';
import 'package:nvp_test/views/pages/login/login_page.dart';
import 'package:nvp_test/views/pages/main/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(milliseconds: 800);
    final user = await AuthService().checkUserLogin();
    return Timer(duration, () {
      if (user) {
        NotificationService().subscribeToTopic(NotificationTopics.topic);
        Get.offAll(const MainPage());
      } else {
        NotificationService().unsubscribeFromTopic(NotificationTopics.topic);
        Get.offAll(const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: Get.width * 0.3,
          ),
        ),
      ),
    );
  }
}
