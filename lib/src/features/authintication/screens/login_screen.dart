import 'package:flutter/material.dart';
import 'package:starter_riverpod/src/core/core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login Account',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Hello, Login to use the app',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppGaps.large,
              AppTextField(
                title: "Company URL",
                hintText: "Enter company URL",
              ),
              AppGaps.large,
              AppTextField(
                title: "User name",
                hintText: "User name",
              ),
              AppGaps.large,
              AppTextField(
                title: "Password",
                hintText: "Password",
                isPassword: true,
              ),
              AppGaps.medium,
              InkWell(
                child: Text(
                  "Forgot your password ?",
                ),
              ),
              AppGaps.medium,
              AppCheckbox(
                description: "Keep me logged in",
                onChanged: (newValue) {},
              ),
              AppGaps.xSmall,
              AppCheckbox(
                description: "Accept terms and conditions",
                onChanged: (newValue) {},
              ),
              AppGaps.large,
              AppButton(
                "Login",
                onTap: () {},
                isLoading: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
