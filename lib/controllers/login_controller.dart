import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nvp_test/helpers/error_message_mapper.dart';
import 'package:nvp_test/helpers/validation.dart';
import 'package:nvp_test/model/login_model.dart';
import 'package:nvp_test/services/auth_service.dart';
import 'package:nvp_test/services/notification_service.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/main/main_page.dart';

class LoginController extends GetxController {
  final AuthService _authServices = AuthService();
  RxBool showPassword = false.obs;
  RxBool isSubmitted = false.obs;

  // validation
  RxString emailValidation = "".obs;
  RxString passwordValidation = "".obs;

  void login({required LoginModel data}) async {
    if (validateForm(data: data)) {
      return;
    }
    doLogin(data: data);
  }

  bool validateForm({required LoginModel data}) {
    emailValidation.value = data.email?.isNotEmpty ?? false
        ? ""
        : AppLocalizations.of(Get.context!)?.emailIsRequired ?? '';
    if (data.email?.isNotEmpty ?? false) {
      emailValidation.value = InputValidation.validateEmail(data.email ?? '')
          ? ''
          : AppLocalizations.of(Get.context!)?.pleaseEnterAValidEmail ?? '';
    }
    passwordValidation.value = data.email?.isNotEmpty ?? false
        ? ""
        : AppLocalizations.of(Get.context!)?.passwordIsRequired ?? '';
    return emailValidation.isNotEmpty || passwordValidation.isNotEmpty;
  }

  void doLogin({required LoginModel data}) async {
    isSubmitted.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      User? user = await _authServices.signIn(model: data);
      if (user != null) {
        Fluttertoast.showToast(
            msg: "Login Successfuly",
            backgroundColor: successColor,
            toastLength: Toast.LENGTH_LONG);
        NotificationService().subscribeToTopic(NotificationTopics.topic);
        Get.offAll(const MainPage());
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: ErrorMessageMapper.getErrorMessage(e.code),
          backgroundColor: errorColor,
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          backgroundColor: errorColor,
          toastLength: Toast.LENGTH_LONG);
    }
    isSubmitted.value = false;
  }
}
