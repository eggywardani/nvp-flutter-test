import 'package:nvp_test/helpers/exception.dart';

class InputValidation {
  static bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  static validateRequired(Map<String, dynamic> data) {
    for (final field in data.keys) {
      if (data[field]!.isEmpty) {
        throw CustomException(message: "$field is required");
      }
    }
  }

  static String errorMessageCustom(Map<String, dynamic> body) {
    String message = "";
    if (body['error'] != null) {
      message = _listErrorMessage(body['error']);
    } else {
      message = body['message'] ?? 'something wrong';
    }
    return message;
  }

  static Map<String, dynamic> offlineErrorMessage(Map<String, dynamic> errors) {
    var message = "";
    for (final field in errors.keys) {
      if (errors[field]!.isEmpty) {
        message += "- $field is required " '\n';
      }
    }
    return {"message": message, "pass": message.isEmpty};
  }

  static String _listErrorMessage(Map<String, dynamic> errors) {
    String errorMessage = '';
    if (errors.entries.length > 1) {
      errorMessage = errors.entries
          .map((entry) => "- ${entry.value.join(', ')}")
          .join('\n');
    } else {
      errorMessage =
          errors.entries.map((entry) => "${entry.value.join(', ')}").join('\n');
    }

    return errorMessage;
  }
}
