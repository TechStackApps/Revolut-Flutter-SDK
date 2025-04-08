import 'package:flutter/material.dart';
import 'package:revolut_demo_app/helpers/app_bottom_navigation.dart';
import 'package:revolut_demo_app/screens/revolut_flutter_sdk_demo_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _offsetX = 450.0; // Start off-screen (to the right)

  @override
  void initState() {
    super.initState();

    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _offsetX = 0; // Move to center
      });
    });

    // Navigate after delay
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RevolutFlutterCheckoutDemo(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2), // Smooth transition
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(_offsetX, 0, 0), // Slide effect
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Image.asset("assets/images/splash.png"),
          ),
        ),
      ),
    );
  }
}