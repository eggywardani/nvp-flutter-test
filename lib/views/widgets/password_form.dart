import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm(
      {super.key,
      required this.showPassword,
      required this.textEditingController,
      required this.text,
      this.isRequired = false,
      this.inputType = TextInputType.text,
      this.messageValidation});
  final TextEditingController textEditingController;
  final String text;
  final bool? isRequired;
  final TextInputType inputType;
  final RxBool showPassword;
  final RxString? messageValidation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(text: text, style: const TextStyle(), children: [
            TextSpan(
                text: isRequired ?? false ? '*' : '',
                style: const TextStyle(color: Colors.red)),
          ])),
          const SizedBox(
            height: 10,
          ),
          Obx(() => TextField(
                style: Theme.of(Get.context!).textTheme.titleSmall,
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.text,
                obscureText: !showPassword.value,
                controller: textEditingController,
                decoration: InputDecoration(
                  errorText: messageValidation == null ||
                          messageValidation?.value == ""
                      ? null
                      : messageValidation?.value,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 10, right: 10),
                  labelText: text,
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                  hintText: text,
                  labelStyle: TextStyle(color: Colors.grey.shade400),
                  suffixIcon: IconButton(
                    icon: !showPassword.value
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                    onPressed: () => showPassword.value = !showPassword.value,
                    color: Colors.grey[400],
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5)),
                ),
              )),
        ],
      ),
    );
  }
}
