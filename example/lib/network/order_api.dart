import 'package:dio/dio.dart';
import 'package:revolut_demo_app/network/dio_client.dart';
import 'package:revolut_payments_flutter/helpers/enums.dart';
import 'package:revolut_payments_flutter/revolut_payment.dart';

class OrderApi {
  final DioClient _dioClient = DioClient();

  Future<String> createOrder(
      int amount, String currency, String secretKey) async {
    final baseUrl = RevolutPayment.environment == RevolutEnvironment.PRODUCTION
        ? "https://merchant.revolut.com/api/1.0/orders"
        : "https://sandbox-merchant.revolut.com/api/1.0/orders";

    try {
      final response = await _dioClient.post(
        baseUrl,
        data: {"amount": amount, "currency": currency},
        options: Options(headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/json"
        }),
      );
      return response.data["public_id"];
    } on Exception catch (e) {
      return "Unexpected error: $e";
    }
  }
}
