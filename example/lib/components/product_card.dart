import 'package:flutter/material.dart';
import 'package:revolut_demo_app/screens/revolut_flutter_sdk_demo_page.dart';
import 'package:revolut_demo_app/theme/theme.dart';

class ProductCard extends StatelessWidget {
  final bool isEnvSet;

  const ProductCard({
    super.key,
    required this.isEnvSet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/thsirt_TSA.png',
              height: 220,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Cool black T-Shirt",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Price: \$$amount",
            style: TextStyle(fontSize: 18, color: TColors.secondaryColor),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
