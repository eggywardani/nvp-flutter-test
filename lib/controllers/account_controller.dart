import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nvp_test/model/register_model.dart';
import 'package:nvp_test/services/auth_service.dart';
import 'package:nvp_test/services/firestore_service.dart';
import 'package:nvp_test/services/notification_service.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/login/login_page.dart';

class AccountController extends GetxController {
  Stream<RegisterModel?> getUserData() async* {
    final uid = AuthService().getUid();
    final data = FirestoreServices().getUserModelStream(uid);

    yield* data;
  }

  RxBool isSubmittedButton = false.obs;
  RxBool isSubmittedButtonNotification = false.obs;

  void logout() async {
    isSubmittedButton.value = true;
    await AuthService().logout();

    isSubmittedButton.value = false;
    NotificationService().unsubscribeFromTopic(NotificationTopics.topic);
    Get.offAll(const LoginPage());
  }

  void sendNotification(
      {required String title, required String message}) async {
    isSubmittedButtonNotification.value = true;
    try {
      final result = await NotificationService()
          .sendNotification(title, message, NotificationTopics.topic);
      Fluttertoast.showToast(
          msg: result,
          backgroundColor: errorColor,
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          backgroundColor: errorColor,
          toastLength: Toast.LENGTH_LONG);
    }
    isSubmittedButtonNotification.value = false;
  }
}
