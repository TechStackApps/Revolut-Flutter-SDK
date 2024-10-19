# **Revolut Flutter SDK**

## Download Revolut Flutter SDK
Streamline your payment integration with the Revolut Flutter SDK. Download it today and start accepting payments in minutes!

[![Download Revolut Flutter SDK](./docs/assets/download-revolut-flutter-sdk.png)](https://techstackapps.com/portfolio/revolut-flutter-sdk/)


The `Flutter Revolut Payment SDK` allows you to easily accept payments using the payment solution developed by `Revolut` for businesses, [Payment Gateway](https://www.revolut.com/business/payment-gateway/).

This package wraps the existing `Android` and `iOS` native SDKs , `Revolut Pay` and `Revolut Card Payments`, found [here](https://bitbucket.org/revolut/workspace/projects/PUBLIC), and makes them work in the `Flutter` framework. By doing this, it simplifies the process to initiate a payment and interact with the Revolut backend to verify the payment status.

##### NOTE

In order to use and accept card payments with `Revolut`, you need to have been [accepted as a Merchant](https://www.revolut.com/business/help/merchant-accounts/getting-started/how-do-i-apply-for-a-merchant-account) in your [Revolut Business](https://business.revolut.com/merchant) account.

Some helpful links:
- More information on the [Merchant API](https://developer.revolut.com/docs/accept-payments/)
- [API Reference](https://developer.revolut.com/docs/api-reference/merchant)

## Local installation

1. [Download the package zip.](https://techstackapps.com/portfolio/revolut-flutter-sdk/)
2. Unzip the package
3. Add the package dependency to `pubspec.yaml` using the path you saved the package to:
   ```
   flutter_revolut_payment:
    path: [Path to package]
   ```

### Requirements

|         |            Version |
|---------|-------------------:|
| Dart    |             2.16.2 |
| Flutter |             2.10.4 |
| Android | 5.0 (Api level 21) |
| iOS     |                 13 |

For `iOS` you also have to change the `Podfile` in the `ios` folder of your project so that `CocoaPods` installs the pod for this package as static:

```
target 'Runner' do
  use_frameworks! :linkage => :static

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

## Usage
This SDK offers two different ways of accepting payments made to your Business account: directly accepting a card payment, or accepting a payment through the `Revolut` app using `Revolut Pay`.

Before everything, you need to be aware of your Merchant API keys. The public key will be used to initialise the SDK, while the secret key will be used as authorisation for the API calls.

To initialise the package in your `Flutter` app, use the `RevolutPayment` base class. First set the `merchantPublicKey` and the `environment`, which is either `RevolutEnvironment.SANDBOX` or `RevolutEnvironment.PRODUCTION`, then call the `applySettings()` function:

```dart
RevolutPayment.environment = RevolutEnvironment.[ENV];
RevolutPayment.merchantPublicKey ="[publicKey]";
await  RevolutPayment.instance.applySettings();
``` 

## The payment flow

After initialisation, when you want to accept a payment in your app the first thing you need to do is create an order on the `Revolut` backend with the needed amount and currency:
```
curl -X "POST" "https://merchant.revolut.com/api/1.0/orders" \
   -H 'Authorization: Bearer [secretKey]' \
   -H 'Content-Type: application/json; charset=utf-8' \
   -d $'{
     "amount": 100,
     "currency": "GBP"
    }'
```

The API will return a JSON when the order is successfully created from which you need the `public_id` in order to start a payment.

The next steps are different for the two ways of accepting payments.

### 1. Revolut Card Payments

![Card payment demo](./docs/assets/card_payment_demo.gif)

In order to accept direct card payments, you need to call the `startCardPayment(orderId, configuration)` asynchronous function. This will bring up the payment screen where the user can enter their card information. The function returns the `"authorised"` string if successful or throws a `RevolutCardPaymentException` for all failure cases.

The parameters:
- `orderId` is the above-mentioned public_id of the order 
-  `configuration` is an object of type `CardPaymentConfiguration` that is optional and passes the e-mail and address of the user

Usage example:
```dart
try {
	await  RevolutPayment.instance.startCardPayment(
		orderId: revolutOrderId,
		//configuration is optional
		configuration: CardPaymentConfiguration(
			email: email,
			billingAddress: CardBillingAddress(
				streetLine1: line1,
				streetLine2: line2,
				city: city,
				region: region,
				countryIsoCode: isoCode,
				postcode: postCode)));
	//success case
} catch (e) {
	if (e  is  RevolutCardPaymentException) {
		//payment failure case
	} else {
		//general failure case
	}
}
```

### 2. Revolut Pay

![Revolut Pay demo](./docs/assets/revolut_pay_demo.gif)

This payment method lets the user make payments more easily using their `Revolut` account, if they have one. To add this functionality to your app you only need to add the `RevolutPayButton` widget to your screen. When the user taps the button there are two possible things that can happen:
- if the `Revolut` app is installed on their phone, the user is taken to it and can pay there
- if the `Revolut` app is not installed, the user is taken to a webview with a card form similar to the other payment method
(this is true only for the production environment, in sandbox the user is never taken to the `Revolut` app even if it's installed)

If the payment is successful, the widget calls the `onSucceeded` void callback. If it fails for whatever reason, it calls the `onFailed(errorMessage)` callback. You need to provide these callbacks when you instantiate the button.

Usage example:
```dart
RevolutPayButton(
	orderPublicId: revolutOrderId,
	height: height,
	width: width,
	buttonParams: RevolutPayButtonParams(
		radius: RevolutPayRadius.LARGE,
		size: RevolutPaySize.MEDIUM,
		//lightMode and darkMode are optional
		lightMode: RevolutPayVariant.LIGHT_OUTLINED,
		darkMode: RevolutPayVariant.DARK_OUTLINED),
	onSucceeded: () {
		//success case
	},
	//onFailed is optional
	onFailed: (message) {
		//failure case
	}
)
```

The SDK also offers the possibility of checking if the `Revolut` app is installed on the user's device using the `isRevolutAppInstalled()` function which returns a bool.

#### Support the Revolut app URL scheme
If you want the widget to be able to open the `Revolut` app you need to add the relevant URL scheme to your application:

For `Android` you need to add the following to your `AndroidManifest.xml`:
```xml
<queries>
    <package android:name="com.revolut.revolut" />
</queries>
```

For `iOS` add to your `Info.plist` file:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>revolut</string>
</array>
```

## Example app
This package comes with an example application that presents the functionality of both payment methods in a straightforward manner. To run it:
```sh
cd example
flutter pub get
flutter run 
```