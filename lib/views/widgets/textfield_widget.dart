import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textfieldUnderline(
    {required TextEditingController controller,
    required String hintText,
    required TextInputType inputType,
    Widget? suffix,
    bool readOnly = false,
    void Function(String)? onChanged}) {
  return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      keyboardType: inputType,
      readOnly: readOnly,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 5),
        isDense: true,
        hintText: hintText,
        suffix: suffix,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      ));
}

Widget textfieldUnderlineSuffix(
    {required TextEditingController controller,
    required String hintText,
    required TextInputType inputType,
    required Widget suffix,
    void Function()? onTap}) {
  return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      keyboardType: inputType,
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hintText,
        suffix: suffix,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      ));
}

Widget textfieldOutlined(
    {required TextEditingController controller,
    required String hintText,
    bool readOnly = false,
    required TextInputType inputType,
    void Function()? onTap,
    String? errorText}) {
  return TextField(
      style: Theme.of(Get.context!).textTheme.titleSmall,
      controller: controller,
      keyboardType: inputType,
      readOnly: readOnly,
      minLines: 1,
      onTap: onTap,
      maxLines: inputType == TextInputType.multiline ? 10 : 1,
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding:
            const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        hintText: hintText,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(5)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(5)),
        labelStyle: TextStyle(color: Colors.grey.shade400),
      ));
}
