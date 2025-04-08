import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:revolut_demo_app/components/order_card.dart';
import 'package:revolut_demo_app/components/product_card.dart';
import 'package:revolut_demo_app/components/rev_buttons.dart';
import 'package:revolut_demo_app/helpers/app_bottom_navigation.dart';
import 'package:revolut_demo_app/network/order_api.dart';
import 'package:revolut_demo_app/screens/home_page.dart';
import 'package:revolut_demo_app/theme/theme.dart';
import 'package:revolut_payments_flutter/helpers/enums.dart';
import 'package:revolut_payments_flutter/revolut_payment.dart';

String amount = '30';

class RevolutFlutterCheckoutDemo extends StatefulWidget {
  const RevolutFlutterCheckoutDemo({super.key});

  @override
  State<RevolutFlutterCheckoutDemo> createState() => _RevolutFlutterCheckoutDemoState();
}

class _RevolutFlutterCheckoutDemoState extends State<RevolutFlutterCheckoutDemo> {
  final List<bool> _envToggleIsSelected = [false, false];
  final _orderApi = OrderApi();
  String _dropdownValue = 'USD';

  String? _selectedEnvironment;
  bool _isEnvSet = false;
  bool _orderCreated = false;
  int? _amountInCents;

  final _orderIdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: TColors.secondaryColor,
        title: Center(
          child: Text(
            'Revolut Flutter SDK Demo',
            style: TextStyle(color: TColors.whiteTextColor, fontSize: 26),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    !_isEnvSet
                        ? Column(
                            children: [
                              const Text(
                                "Set environment:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              ToggleButtons(
                                selectedColor: Colors.white,
                                fillColor: TColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                                isSelected: _envToggleIsSelected,
                                onPressed: (index) {
                                  if (_isEnvSet) return;
                                  for (int i = 0; i < 2; i++) {
                                    _envToggleIsSelected[i] = i == index;
                                  }
                                  _selectedEnvironment = index == 0 ? "SANDBOX" : "PRODUCTION";
                                  setState(() {});
                                },
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "SANDBOX",
                                      style: TextStyle(
                                        color: _envToggleIsSelected[0] ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "PRODUCTION",
                                      style: TextStyle(
                                        color: _envToggleIsSelected[1] ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              MaterialButton(
                                height: 40,
                                color: TColors.primaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                textColor: Colors.white,
                                onPressed: _isEnvSet ? null : _saveSettings,
                                child: const Text("Save settings"),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Environment: $_selectedEnvironment",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: TColors.blackTextColor,
                              ),
                            ),
                          ),
                    if (_isEnvSet && !_orderCreated)
                      Column(
                        children: [
                          ProductCard(isEnvSet: _isEnvSet),
                          const SizedBox(height: 40),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            color:
                                _isEnvSet ? TColors.primaryColor : Colors.grey,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            textColor: Colors.white,
                            onPressed: _isEnvSet
                                ? () {
                                    setState(() {
                                      amount = "30";
                                      _dropdownValue = "USD";
                                    });
                                    _createOrder();
                                  }
                                : null,
                            child: const Text("Add to Cart"),
                          ),
                        ],
                      ),
                    if (_orderCreated)
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            OrderCard(
                              amount: amount,
                              currency: _dropdownValue,
                            ),
                            const SizedBox(height: 40),
                            RevolutButtons(
                              orderId: _orderIdTextController.text,
                              amount: _amountInCents ?? 0,
                              currency: _dropdownValue,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _saveSettings() async {
    if (!_envToggleIsSelected.contains(true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "PLEASE SELECT AN ENV, IT IS MANDATORY",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    String? secretKey = _envToggleIsSelected[0]
        ? dotenv.env['MERCHANT_SANDBOX_SECRET_KEY']
        : dotenv.env['MERCHANT_PRODUCTION_SECRET_KEY'];

    String? publicKey = _envToggleIsSelected[0]
        ? dotenv.env['MERCHANT_SANDBOX_PUBLIC_KEY']
        : dotenv.env['MERCHANT_PRODUCTION_PUBLIC_KEY'];

    if (secretKey == null || secretKey.isEmpty || publicKey == null || publicKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "ERROR: Missing environment variables. Please check your .env file.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    RevolutPayment.environment = _envToggleIsSelected[0]
        ? RevolutEnvironment.SANDBOX
        : RevolutEnvironment.PRODUCTION;
    RevolutPayment.merchantPublicKey = publicKey;
    await RevolutPayment.instance.applySettings();

    setState(() {
      _isEnvSet = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Environment has been set to:",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              _selectedEnvironment ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: TColors.whiteTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        backgroundColor: TColors.secondaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _getSecretKey() {
    String? secretKey = _envToggleIsSelected[0]
        ? dotenv.env['MERCHANT_SANDBOX_SECRET_KEY']
        : dotenv.env['MERCHANT_PRODUCTION_SECRET_KEY'];

    if (secretKey == null || secretKey.isEmpty) {
      throw Exception("Missing environment variable: Secret key is not set.");
    }

    return secretKey;
  }

  void _createOrder() async {
    if (amount.isEmpty || int.tryParse(amount) == null) return;

    int amountInCents = int.parse(amount) * 100;
    String secretKey = _getSecretKey();

    try {
      String orderPublicId =
          await _orderApi.createOrder(amountInCents, _dropdownValue, secretKey);

      setState(() {
        _orderIdTextController.text = orderPublicId;
        _amountInCents = amountInCents;
        _orderCreated = true;
      });
    } catch (e, stackTrace) {
      debugPrint("Error creating order: $e\n$stackTrace");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create order. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
