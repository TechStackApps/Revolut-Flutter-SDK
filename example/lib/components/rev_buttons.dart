import 'package:flutter/material.dart';
import 'package:revolut_demo_app/screens/success_screen.dart';
import 'package:revolut_payments_flutter/helpers/flutter_style_buttons/button_style_utils.dart';
import 'package:revolut_payments_flutter/helpers/revolut_card_payments/card_payment_configuration.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/custom_revolut_apple_pay_button.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/custom_revolut_pay_button.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/revolut_card_button.dart';

class RevolutButtons extends StatefulWidget {
  const RevolutButtons({
    super.key,
    required this.orderId,
    required this.amount,
    required this.currency,
  });

  final String orderId;
  final int amount;
  final String currency;

  @override
  State<RevolutButtons> createState() => _RevolutButtonsState();
}

class _RevolutButtonsState extends State<RevolutButtons> {
  String _output = "";

  void _onSucceeded() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessScreen(
          outputMessage: _output,
          amount: widget.amount.toString(),
          currency: widget.currency,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RevolutCardButton(
          orderPublicId: widget.orderId,
          buttonRadius: ButtonRadius.full,
          buttonSize: ButtonSize.fullWidth,
          configuration: CardPaymentConfiguration(),
          customIconSize: 23,
          onSucceeded: _onSucceeded,
        ),
        const SizedBox(height: 30),
        CustomRevolutPayButton(
          buttonRadius: ButtonRadius.full,
          buttonSize: ButtonSize.fullWidth,
          iconSize: IconSize.large,
          orderPublicId: widget.orderId,
          onSucceeded: _onSucceeded,
          onFailed: (msg) => setState(() => _output = msg),
        ),
        const SizedBox(height: 30),
        CustomRevolutApplePayButton(
          orderPublicId: widget.orderId,
          amount: widget.amount,
          currency: widget.currency,
          buttonRadius: ButtonRadius.full,
          buttonSize: ButtonSize.fullWidth,
          iconSize: IconSize.large,
          onSucceeded: (){},
        )
      ],
    );
  }
}
