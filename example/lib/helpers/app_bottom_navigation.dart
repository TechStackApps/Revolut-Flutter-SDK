import 'package:flutter/material.dart';
import 'package:revolut_demo_app/theme/theme.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: TColors.whiteTextColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Made by ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            Image.asset(
              'assets/images/TechStackAppsLogo_logo.png',
              fit: BoxFit.contain,
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}