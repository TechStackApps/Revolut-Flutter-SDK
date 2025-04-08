import 'package:flutter/material.dart';
import 'package:revolut_demo_app/components/order_card.dart';
import 'package:revolut_demo_app/helpers/app_bottom_navigation.dart';
import 'package:revolut_demo_app/screens/revolut_flutter_sdk_demo_page.dart';
import 'package:revolut_demo_app/theme/theme.dart';

class SuccessScreen extends StatelessWidget {
  final String outputMessage;
  final String amount;
  final String currency;

  const SuccessScreen({
    super.key,
    required this.outputMessage,
    required this.amount,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: TColors.whiteTextColor),
        backgroundColor: TColors.secondaryColor,
        title: const Text(
          "Payment Successful",
          style: TextStyle(color: TColors.whiteTextColor),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                outputMessage,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              OrderCard(
                amount: (int.parse(amount) / 100).toStringAsFixed(2),
                currency: currency,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MaterialButton(
                  height: 50,
                  color: TColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RevolutFlutterCheckoutDemo(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
