import 'package:flutter/material.dart';
import 'package:subproject1/style/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.biruTua,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: AppColors.abuAbuMuda,
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 13,
              color: AppColors.biruTua,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
