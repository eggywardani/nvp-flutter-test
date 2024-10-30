import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvp_test/theme/app_color.dart';

Widget errorWidget({required void Function()? onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          CupertinoIcons.exclamationmark_triangle,
          color: primaryColor,
          size: 80,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Something wrong",
          textAlign: TextAlign.center,
          style: TextStyle(color: textPrimary),
        ),
        const Text(
          "Please try again",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Try again',
            style: TextStyle(color: primaryColor),
          ),
        )
      ],
    ),
  );
}
