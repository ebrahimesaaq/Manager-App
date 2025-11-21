import 'package:flutter/material.dart';
import 'package:manager_app/core/constants/app_colors.dart';

class AppButtons extends StatelessWidget {
  final String btnName;
  
  final void Function()? onPress;
  const AppButtons({
    super.key,
    required this.btnName,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder?>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.blueButtons),
      ),
      child: Text(
        btnName,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
