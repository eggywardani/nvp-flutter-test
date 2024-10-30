import 'package:flutter/material.dart';
import 'package:nvp_test/theme/app_color.dart';

Widget loadingBottomPaginationWidget() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            strokeWidth: 2,
          ),
        )
      ],
    ),
  );
}

Widget loadingWidget() {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        strokeWidth: 2,
      ),
    ],
  );
}
