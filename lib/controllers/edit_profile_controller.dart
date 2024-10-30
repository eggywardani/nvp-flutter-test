import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nvp_test/helpers/error_message_mapper.dart';
import 'package:nvp_test/model/edit_profile_model.dart';
import 'package:nvp_test/services/auth_service.dart';
import 'package:nvp_test/services/firestore_service.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/main/main_page.dart';

class EditProfileController extends GetxController {
  final FirestoreServices _firestoreService = FirestoreServices();
  RxBool isSubmitted = false.obs;
  Rxn<LatLng> selectedLocation = Rxn<LatLng>();

  // validation
  RxString nameValidation = "".obs;
  RxString locationValidation = "".obs;

  void updateProfile({required EditProfileModel data}) async {
    if (validateForm(data: data)) {
      return;
    }
    doUpdate(data: data);
  }

  bool validateForm({required EditProfileModel data}) {
    nameValidation.value = data.name?.isNotEmpty ?? false
        ? ""
        : AppLocalizations.of(Get.context!)?.nameIsRequired ?? '';

    locationValidation.value = selectedLocation.value != null
        ? ""
        : AppLocalizations.of(Get.context!)?.locationIsRequired ?? '';
    return nameValidation.isNotEmpty || locationValidation.isNotEmpty;
  }

  void doUpdate({required EditProfileModel data}) async {
    isSubmitted.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    final uid = AuthService().getUid();
    try {
      await _firestoreService.editProfile(uid: uid, model: data);
      Fluttertoast.showToast(
          msg: "Update Successfuly",
          backgroundColor: successColor,
          toastLength: Toast.LENGTH_LONG);
      Get.offAll(const MainPage(
        currentIndex: 1,
      ));
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
