import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_constants.dart';

/// حقل نص مخصص يستخدم لرقم الهاتف أو كلمة المرور وغيرها.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLength;
  final bool showCounter;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.maxLength,
    this.showCounter = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,

      buildCounter: showCounter ? null : (context, 
      {required currentLength, required isFocused, required maxLength}) 
      => const SizedBox.shrink(),
      
      style: AppStyles.labelStyle.copyWith(color: AppColors.primaryText),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
