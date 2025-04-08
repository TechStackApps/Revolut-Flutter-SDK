import 'package:flutter/material.dart';
import 'package:revolut_demo_app/helpers/app_bottom_navigation.dart';
import 'package:revolut_demo_app/theme/theme.dart';
import 'package:revolut_payments_flutter/helpers/flutter_style_buttons/button_style_utils.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/custom_revolut_pay_button.dart';


class RevolutPayButtonPage extends StatelessWidget {
  const RevolutPayButtonPage({super.key});

  static const String _demoOrderId = 'order_123';

  static const EdgeInsets _sectionPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const double _verticalSpacing = 15;
  static const double _itemSpacing = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      appBar: _buildAppBar(),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Revolut Pay Button Style",
        style: TextStyle(color: TColors.whiteTextColor),
      ),
      backgroundColor: TColors.secondaryColor,
      centerTitle: false,
      iconTheme: const IconThemeData(
        color: TColors.whiteTextColor,
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExpandableType("iOS", ButtonIconType.ios),
          const SizedBox(height: _verticalSpacing),
          _buildExpandableType("Android", ButtonIconType.android),
          const SizedBox(height: _verticalSpacing),
          _buildExpandableType("RPay", ButtonIconType.rPay),
        ],
      ),
    );
  }

  Widget _buildExpandableType(String title, ButtonIconType type) {
    return ExpansionTile(
      backgroundColor: TColors.greyLight,
      collapsedBackgroundColor: TColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tilePadding: _sectionPadding,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildDisabledButton(
            CustomRevolutPayButton(
              orderPublicId: _demoOrderId,
              onSucceeded: () {},
              buttonIconType: type,
              variant: ButtonVariant.dark,
            ),
          ),
          const SizedBox(width: _verticalSpacing),
          const Expanded(
            child: Text(
              "Tap to expand",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      children: [
        _buildVariantSection(type),
        _buildSizeSection(type),
        _buildRadiusSection(type),
        _buildCustomSizesSection(type),
      ],
    );
  }

  Widget _buildVariantSection(ButtonIconType type) {
    return _buildCategorySection(
      "Variant",
      [
        _buildButtonWithLabel(type, variant: ButtonVariant.dark),
        _buildButtonWithLabel(type, variant: ButtonVariant.lightWithBorder),
        _buildButtonWithLabel(type, variant: ButtonVariant.lightWithoutBorder),
      ],
    );
  }

  Widget _buildSizeSection(ButtonIconType type) {
    return _buildCategorySection(
      "Size",
      [
        _buildButtonWithLabel(
          type,
          buttonSize: ButtonSize.small,
          iconSize: IconSize.small,
          label: ButtonSize.small.name,
        ),
        _buildButtonWithLabel(
          type,
          label: ButtonSize.regular.name,
        ),
        _buildButtonWithLabel(
          type,
          buttonSize: ButtonSize.large,
          iconSize: IconSize.large,
          label: ButtonSize.large.name,
        ),
        Text(
          "${ButtonSize.fullWidth.name} ↓",
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        _buildDisabledButton(
          CustomRevolutPayButton(
            orderPublicId: _demoOrderId,
            onSucceeded: () {},
            buttonIconType: type,
            buttonSize: ButtonSize.fullWidth,
            iconSize: IconSize.large,
          ),
        ),
      ],
    );
  }

  Widget _buildRadiusSection(ButtonIconType type) {
    return _buildCategorySection(
      "Radius",
      [
        _buildButtonWithLabel(
          type,
          buttonRadius: ButtonRadius.small,
          label: ButtonRadius.small.name,
        ),
        _buildButtonWithLabel(
          type,
          buttonRadius: ButtonRadius.regular,
          label: ButtonRadius.regular.name,
        ),
        _buildButtonWithLabel(
          type,
          buttonRadius: ButtonRadius.full,
          label: ButtonRadius.large.name,
        ),
      ],
    );
  }

  Widget _buildCustomSizesSection(ButtonIconType type) {
    return _buildCategorySection(
      "Custom Sizes",
      [
        _buildDisabledButton(
          CustomRevolutPayButton(
            orderPublicId: _demoOrderId,
            onSucceeded: () {},
            buttonIconType: type,
            buttonSize: ButtonSize.fullWidth,
            customHeight: 45,
            customWidth: 160,
            customIconSize: 20,
            customRadius: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(String title, List<Widget> buttons) {
    return Padding(
      padding: _sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: _itemSpacing),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buttons
                .map(
                  (button) => Padding(
                padding: const EdgeInsets.only(bottom: _itemSpacing),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: button,
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWithLabel(
      ButtonIconType type, {
        ButtonVariant variant = ButtonVariant.dark,
        ButtonSize buttonSize = ButtonSize.regular,
        ButtonRadius buttonRadius = ButtonRadius.regular,
        IconSize iconSize = IconSize.regular,
        String? label,
      }) {
    final displayLabel = label ?? variant.name;

    return Row(
      children: [
        _buildDisabledButton(
          CustomRevolutPayButton(
            orderPublicId: _demoOrderId,
            onSucceeded: () {},
            buttonIconType: type,
            variant: variant,
            buttonSize: buttonSize,
            buttonRadius: buttonRadius,
            iconSize: iconSize,
          ),
        ),
        const SizedBox(width: _itemSpacing),
        Text(
          displayLabel,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDisabledButton(Widget button) {
    return IgnorePointer(
      ignoring: true,
      child: button,
    );
  }
}