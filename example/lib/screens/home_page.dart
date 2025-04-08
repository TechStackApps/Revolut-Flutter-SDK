import 'package:flutter/material.dart';
import 'package:revolut_demo_app/helpers/app_bottom_navigation.dart';
import 'package:revolut_demo_app/screens/buttons_page.dart';
import 'package:revolut_demo_app/screens/revolut_flutter_sdk_demo_page.dart';
import 'package:revolut_demo_app/theme/theme.dart';
import 'package:revolut_payments_flutter/revolut_payment.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _checkRevolutInstallation(BuildContext context) async {
    bool isInstalled = await RevolutPayment.instance.isRevolutAppInstalled();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isInstalled
              ? "Revolut App is installed"
              : "Revolut App is NOT installed",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: TColors.whiteTextColor,
          ),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 2),
        backgroundColor:
            isInstalled ? TColors.secondaryColor : TColors.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.secondaryColor,
        title: const Text(
          "Home",
          style: TextStyle(color: TColors.whiteTextColor, fontSize: 26),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 18,
          children: [
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                height: 50,
                color: TColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RevolutFlutterCheckoutDemo(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Revolut Flutter Checkout Demo",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                height: 50,
                color: TColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ButtonsPage(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Button Styles",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                height: 50,
                color: TColors.primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                textColor: Colors.white,
                onPressed: () => _checkRevolutInstallation(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Check if Revolut App is installed",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
