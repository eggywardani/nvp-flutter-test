import 'package:get/get.dart';
import 'package:nvp_test/model/register_model.dart';
import 'package:nvp_test/services/auth_service.dart';
import 'package:nvp_test/services/firestore_service.dart';

class HomeController extends GetxController {
  Stream<RegisterModel?> getUserData() async* {
    final uid = AuthService().getUid();
    final data = FirestoreServices().getUserModelStream(uid);

    yield* data;
  }
}
