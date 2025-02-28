import 'package:flutter/material.dart';
import 'package:starter_riverpod/src/core/core.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.isPassword = false,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool isPassword; // New parameter to check if it's a password field

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppGaps.small,
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isPassword
              ? _isObscured
              : false, // Toggle password visibility
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.lightGrey,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFF434343),
                width: 2,
              ),
            ),
            // Password visibility toggle button
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null, // Show icon only if it's a password field
          ),
        ),
      ],
    );
  }
}
