import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.label,
      required this.backgroundColor,
      required this.onPressed,
      this.loading = false,
      this.icon})
      : super(key: key);

  final String label;
  final Color backgroundColor;
  final void Function()? onPressed;
  final Icon? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor:
              loading ? backgroundColor.withOpacity(0.3) : backgroundColor,
          elevation: 0),
      onPressed: loading ? () {} : onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading
                ? Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 10),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: icon == null
                  ? [
                      Text(
                        label,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ]
                  : [
                      icon!,
                      const SizedBox(width: 10),
                      Text(
                        label,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
