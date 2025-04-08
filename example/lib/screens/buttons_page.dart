import 'dart:io';
import 'package:flutter/material.dart';
import 'package:revolut_demo_app/screens/buttons/apple_pay_button_page.dart';
import 'package:revolut_demo_app/screens/buttons/card_button_page.dart';
import 'package:revolut_demo_app/screens/buttons/revolut_pay_button_page.dart';
import 'package:revolut_demo_app/helpers/app_bottom_navigation.dart';
import 'package:revolut_demo_app/theme/theme.dart';
import 'package:revolut_payments_flutter/helpers/flutter_style_buttons/button_style_utils.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/custom_revolut_apple_pay_button.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/custom_revolut_pay_button.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/revolut_card_button.dart';


class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Revolut Buttons",
          style: TextStyle(color: TColors.whiteTextColor),
        ),
        backgroundColor: TColors.secondaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: TColors.whiteTextColor,
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNavigationTile(
              label: 'CARD PAYMENTS',
              context,
              button: RevolutCardButton(
                orderPublicId: "order_123",
              ),
              page: const CardPayButtonPage(),
            ),
            const SizedBox(height: 15),
            _buildNavigationTile(
              label: 'REVOLUT PAY',
              context,
              button: CustomRevolutPayButton(
                buttonRadius: ButtonRadius.full,
                orderPublicId: "order_123",
                onSucceeded: () {},
              ),
              page: const RevolutPayButtonPage(),
            ),
            const SizedBox(height: 15),
            if (Platform.isIOS)
              _buildNavigationTile(
                label: 'APPLE PAY',
                context,
                button: CustomRevolutApplePayButton(
                  orderPublicId: "order_123",
                  amount: 5000,
                  currency: "USD",
                  onSucceeded: () {},
                ),
                page: const ApplePayButtonPage(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationTile(
    BuildContext context, {
    required Widget button,
    required Widget page,
        required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _minimalistButton(context, page, label),
        Text(
          " -> ",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: TColors.primaryColor,
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: button,
        ),
      ],
    );
  }

  Widget _minimalistButton(BuildContext context, Widget page, String label) {
    return SizedBox(
      height: 80,
      width: 200,
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.whiteTextColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        child: Text(
          "View styles for\n$label",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: TColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
