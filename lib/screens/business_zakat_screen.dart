import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_widgets.dart';
import '../constants/app_constants.dart';
import '../constants/translations.dart';

class BusinessZakatScreen extends StatefulWidget {
  const BusinessZakatScreen({super.key});

  @override
  State<BusinessZakatScreen> createState() => _BusinessZakatScreenState();
}

class _BusinessZakatScreenState extends State<BusinessZakatScreen> {
  final _inventoryController = TextEditingController();
  final _receivablesController = TextEditingController();
  final _cashController = TextEditingController();
  final _payablesController = TextEditingController();

  double _netAssets = 0;
  double _zakatAmount = 0;
  bool _nisabReached = false;
  bool _showResults = false;

  double get _nisabValue =>
      ZakatConstants.silverNisabTola * ZakatConstants.defaultSilverRatePerTola;

  void _calculateZakat() {
    double inventory = double.tryParse(_inventoryController.text) ?? 0;
    double receivables = double.tryParse(_receivablesController.text) ?? 0;
    double cash = double.tryParse(_cashController.text) ?? 0;
    double payables = double.tryParse(_payablesController.text) ?? 0;

    _netAssets = inventory + receivables + cash - payables;
    if (_netAssets < 0) _netAssets = 0;
    _nisabReached = _netAssets >= _nisabValue;
    _zakatAmount = _nisabReached
        ? _netAssets * (ZakatConstants.zakatRate / 100)
        : 0;
    setState(() => _showResults = true);
  }

  @override
  void dispose() {
    _inventoryController.dispose();
    _receivablesController.dispose();
    _cashController.dispose();
    _payablesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('business'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('business'),
            fontWeight: FontWeight.bold,
            isTitle: true,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, _zakatAmount),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            SectionHeader(title: AppTranslations.getText('enter_details')),
            ZakatTextField(
              label: AppTranslations.getText('inventory'),
              controller: _inventoryController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.inventory,
            ),
            ZakatTextField(
              label: AppTranslations.getText('receivables'),
              controller: _receivablesController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.receipt,
            ),
            ZakatTextField(
              label: AppTranslations.getText('cash_in_hand'),
              controller: _cashController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.money,
            ),
            const SizedBox(height: 15),
            SectionHeader(title: AppTranslations.getText('payables')),
            ZakatTextField(
              label: AppTranslations.getText('payables'),
              controller: _payablesController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.money_off,
            ),
            const SizedBox(height: 10),
            InfoCard(
              title: AppTranslations.getText('nisab_label'),
              content:
                  '${AppTranslations.getText('nisab_silver')} (Approx Rs. ${AppTranslations.formatNumber(_nisabValue)})',
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 25),
            ZakatCalculateButton(
              text: AppTranslations.getText('calculate'),
              icon: Icons.calculate,
              onPressed: _calculateZakat,
            ),
            const SizedBox(height: 25),
            if (_showResults) _buildResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5D4037), Color(0xFF3E2723)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withAlpha(80)
                  : Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(
              'assets/svg icons/business.svg',
              width: 35,
              height: 35,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTranslations.getText('business'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('business'),
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppTranslations.getText('business_description'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('business_description'),
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    String currency = AppTranslations.getText('currency');
    return Column(
      children: [
        NisabStatusWidget(
          nisabReached: _nisabReached,
          nisabValue: '$currency ${AppTranslations.formatNumber(_nisabValue)}',
          currentValue: '$currency ${AppTranslations.formatNumber(_netAssets)}',
        ),
        const SizedBox(height: 15),
        ZakatResultCard(
          title: 'Net Assets',
          value: '$currency ${AppTranslations.formatNumber(_netAssets)}',
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF5D4037),
        ),
        const SizedBox(height: 15),
        ZakatResultCard(
          title: AppTranslations.getText('zakat_payable'),
          value: '$currency ${AppTranslations.formatNumber(_zakatAmount)}',
          icon: Icons.volunteer_activism,
          isHighlighted: true,
        ),
        const SizedBox(height: 20),
        if (_zakatAmount > 0)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context, _zakatAmount),
              icon: const Icon(Icons.save),
              label: Text(AppTranslations.getText('save_go_back')),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1A5F2C),
                side: const BorderSide(color: Color(0xFF1A5F2C), width: 2),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
