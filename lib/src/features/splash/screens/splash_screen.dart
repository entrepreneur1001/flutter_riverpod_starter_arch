import 'package:flutter/material.dart';
import 'package:starter_riverpod/src/core/constants/assets.dart';
import 'package:starter_riverpod/src/core/constants/colors.dart';
import 'package:starter_riverpod/src/core/widgets/app_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImage(
              path: AppAssets.AppLogo,
            ),
          ],
        ),
      ),
    );
  }
}
