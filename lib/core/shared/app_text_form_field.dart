import 'package:flutter/material.dart';
import 'package:manager_app/core/constants/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final String title;
  final TextEditingController controller;
  final Widget? icon;
  final FormFieldValidator<String>? validator;

  const AppTextFormField({
    super.key,
    required this.label,
    required this.title,
    required this.controller,
    this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              suffixIcon: icon,
              labelStyle: TextStyle(color: AppColors.lightGrey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        ),
      ],
    );
  }
}
