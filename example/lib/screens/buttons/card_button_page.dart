import 'package:flutter/material.dart';
import 'package:revolut_demo_app/helpers/app_bottom_navigation.dart';
import 'package:revolut_demo_app/theme/theme.dart';
import 'package:revolut_payments_flutter/helpers/flutter_style_buttons/button_style_utils.dart';
import 'package:revolut_payments_flutter/widgets/flutter_buttons/revolut_card_button.dart';


class CardPayButtonPage extends StatelessWidget {
  const CardPayButtonPage({super.key});

  static const String _demoOrderId = 'order_123';

  static const double _sectionSpacing = 30;
  static const double _itemSpacing = 10;
  static const EdgeInsets _pagePadding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.greyLight,
      appBar: _buildAppBar(),
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: SingleChildScrollView(child: _buildButtonGroups()),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Card Pay Button Style",
        style: TextStyle(color: TColors.whiteTextColor),
      ),
      backgroundColor: TColors.secondaryColor,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: TColors.whiteTextColor,
      ),
    );
  }

  Widget _buildButtonGroups() {
    return Padding(
      padding: _pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVariantSection(),
          const SizedBox(height: _sectionSpacing),
          _buildSizeSection(),
          const SizedBox(height: _sectionSpacing),
          _buildRadiusSection(),
          const SizedBox(height: _sectionSpacing),
          _buildCustomSizesSection(),
        ],
      ),
    );
  }

  Widget _buildVariantSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Variant"),
        _buildButtonWithLabel(
          variant: ButtonVariant.dark,
          label: ButtonVariant.dark.name,
        ),
        const SizedBox(height: _itemSpacing),
        _buildButtonWithLabel(
          variant: ButtonVariant.lightWithBorder,
          label: ButtonVariant.lightWithBorder.name,
        ),
        const SizedBox(height: _itemSpacing),
        _buildButtonWithLabel(
          variant: ButtonVariant.lightWithoutBorder,
          label: ButtonVariant.lightWithoutBorder.name,
        ),
      ],
    );
  }

  Widget _buildSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Size"),
        _buildButtonWithLabel(
          buttonSize: ButtonSize.small,
          iconSize: IconSize.small,
          label: ButtonSize.small.name,
        ),
        const SizedBox(height: _itemSpacing),
        _buildButtonWithLabel(
          label: ButtonSize.regular.name,
        ),
        const SizedBox(height: _itemSpacing),
        _buildButtonWithLabel(
          buttonSize: ButtonSize.large,
          iconSize: IconSize.large,
          label: ButtonSize.large.name,
        ),
        const SizedBox(height: _itemSpacing),
        Text(
          "${ButtonSize.fullWidth.name} ↓",
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: _itemSpacing / 2),
        _buildDisabledButton(
          RevolutCardButton(
            orderPublicId: _demoOrderId,
            buttonSize: ButtonSize.fullWidth,
            iconSize: IconSize.large,
          ),
        ),
      ],
    );
  }

  Widget _buildRadiusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Radius"),
        _buildButtonWithLabel(
          buttonRadius: ButtonRadius.small,
          label: ButtonRadius.small.name,
        ),
        const SizedBox(height: _itemSpacing),
        _buildButtonWithLabel(
          buttonRadius: ButtonRadius.regular,
          label: ButtonRadius.regular.name,
        ),
        const SizedBox(height: _itemSpacing),
        _buildButtonWithLabel(
          buttonRadius: ButtonRadius.large,
          label: ButtonRadius.large.name,
        ),
        const SizedBox(height: _itemSpacing),
        _buildButtonWithLabel(
          buttonRadius: ButtonRadius.full,
          label: ButtonRadius.full.name,
        ),
      ],
    );
  }

  Widget _buildCustomSizesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Custom Sizes"),
        _buildDisabledButton(
          RevolutCardButton(
            orderPublicId: _demoOrderId,
            customHeight: 45,
            customWidth: 160,
            customIconSize: 20,
            customRadius: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonWithLabel({
    ButtonVariant variant = ButtonVariant.dark,
    ButtonSize buttonSize = ButtonSize.regular,
    ButtonRadius buttonRadius = ButtonRadius.regular,
    IconSize iconSize = IconSize.regular,
    required String label,
  }) {
    return Row(
      children: [
        _buildDisabledButton(
          RevolutCardButton(
            orderPublicId: _demoOrderId,
            variant: variant,
            buttonSize: buttonSize,
            buttonRadius: buttonRadius,
            iconSize: iconSize,
          ),
        ),
        const SizedBox(width: _itemSpacing),
        Text(
          label,
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: _itemSpacing),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}