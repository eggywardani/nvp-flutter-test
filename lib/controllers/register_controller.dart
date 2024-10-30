import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nvp_test/helpers/error_message_mapper.dart';
import 'package:nvp_test/helpers/validation.dart';
import 'package:nvp_test/model/register_model.dart';
import 'package:nvp_test/services/auth_service.dart';
import 'package:nvp_test/services/notification_service.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/main/main_page.dart';

class RegisterController extends GetxController {
  final AuthService _authServices = AuthService();
  RxBool showPassword = false.obs;
  RxBool isSubmitted = false.obs;
  Rxn<LatLng> selectedLocation = Rxn<LatLng>();

  // validation
  RxString emailValidation = "".obs;
  RxString passwordValidation = "".obs;
  RxString nameValidation = "".obs;
  RxString locationValidation = "".obs;

  void register({required RegisterModel data}) async {
    if (validateForm(data: data)) {
      return;
    }
    doRegister(data: data);
  }

  bool validateForm({required RegisterModel data}) {
    emailValidation.value = data.email?.isNotEmpty ?? false
        ? ""
        : AppLocalizations.of(Get.context!)?.emailIsRequired ?? '';
    nameValidation.value = data.email?.isNotEmpty ?? false
        ? ""
        : AppLocalizations.of(Get.context!)?.nameIsRequired ?? '';

    if (data.email?.isNotEmpty ?? false) {
      emailValidation.value = InputValidation.validateEmail(data.email ?? '')
          ? ''
          : AppLocalizations.of(Get.context!)?.pleaseEnterAValidEmail ?? '';
    }
    passwordValidation.value = data.email?.isNotEmpty ?? false
        ? ""
        : AppLocalizations.of(Get.context!)?.passwordIsRequired ?? '';
    locationValidation.value = selectedLocation.value != null
        ? ""
        : AppLocalizations.of(Get.context!)?.locationIsRequired ?? '';
    return emailValidation.isNotEmpty ||
        nameValidation.isNotEmpty ||
        locationValidation.isNotEmpty ||
        passwordValidation.isNotEmpty;
  }

  void doRegister({required RegisterModel data}) async {
    isSubmitted.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      User? user = await _authServices.signUp(model: data);
      if (user != null) {
        Fluttertoast.showToast(
            msg: "Register Successfuly",
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
