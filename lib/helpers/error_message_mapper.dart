import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ErrorMessageMapper {
  static String getErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return AppLocalizations.of(Get.context!)
                ?.accountExistsWithDifferentCredential ??
            '';
      case 'invalid-credential':
        return AppLocalizations.of(Get.context!)?.invalidCredential ?? '';
      case 'operation-not-allowed':
        return AppLocalizations.of(Get.context!)?.operationNotAllowed ?? '';
      case 'user-disabled':
        return AppLocalizations.of(Get.context!)?.userDisabled ?? '';
      case 'user-not-found':
        return AppLocalizations.of(Get.context!)?.userNotFound ?? '';
      case 'wrong-password':
        return AppLocalizations.of(Get.context!)?.wrongPassword ?? '';
      case 'invalid-verification-code':
        return AppLocalizations.of(Get.context!)?.invalidVerificationCode ?? '';
      case 'invalid-verification-id':
        return AppLocalizations.of(Get.context!)?.invalidVerificationId ?? '';
      default:
        return AppLocalizations.of(Get.context!)?.unknownError ?? '';
    }
  }
}
