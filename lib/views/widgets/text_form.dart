import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'textfield_widget.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {super.key,
      required this.textEditingController,
      required this.text,
      this.isRequired = false,
      this.inputType = TextInputType.text,
      this.messageValidation});
  final TextEditingController textEditingController;
  final String text;
  final bool? isRequired;
  final TextInputType inputType;
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
          Obx(() => textfieldOutlined(
              controller: textEditingController,
              hintText: text,
              inputType: inputType,
              errorText:
                  messageValidation == null || messageValidation?.value == ""
                      ? null
                      : messageValidation?.value))
        ],
      ),
    );
  }
}
