import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? okBtn;
  final String? cancelBtn;
  final void Function()? onPressedOk;
  final void Function()? onPressedCancel;
  const CustomDialog(
      {super.key,
      this.title,
      this.content,
      this.okBtn,
      this.cancelBtn,
      this.onPressedOk,
      this.onPressedCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(content!),
      actions: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Text(okBtn!)),
        IconButton(onPressed: onPressedCancel, icon: Text(cancelBtn!)),
      ],
    );
  }
}
