import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_widgets.dart';
import '../constants/app_constants.dart';
import '../constants/translations.dart';

class SharesZakatScreen extends StatefulWidget {
  const SharesZakatScreen({super.key});

  @override
  State<SharesZakatScreen> createState() => _SharesZakatScreenState();
}

class _SharesZakatScreenState extends State<SharesZakatScreen> {
  final _sharesController = TextEditingController();
  final _mutualFundsController = TextEditingController();
  final _bondsController = TextEditingController();
  final _propertyInvestController = TextEditingController();

  double _totalInvestment = 0;
  double _zakatAmount = 0;
  bool _nisabReached = false;
  bool _showResults = false;

  double get _nisabValue =>
      ZakatConstants.silverNisabTola * ZakatConstants.defaultSilverRatePerTola;

  void _calculateZakat() {
    double shares = double.tryParse(_sharesController.text) ?? 0;
    double mutualFunds = double.tryParse(_mutualFundsController.text) ?? 0;
    double bonds = double.tryParse(_bondsController.text) ?? 0;
    double property = double.tryParse(_propertyInvestController.text) ?? 0;

    _totalInvestment = shares + mutualFunds + bonds + property;
    _nisabReached = _totalInvestment >= _nisabValue;
    _zakatAmount = _nisabReached
        ? _totalInvestment * (ZakatConstants.zakatRate / 100)
        : 0;
    setState(() => _showResults = true);
  }

  @override
  void dispose() {
    _sharesController.dispose();
    _mutualFundsController.dispose();
    _bondsController.dispose();
    _propertyInvestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('shares'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('shares'),
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
              label: AppTranslations.getText('shares_value'),
              controller: _sharesController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.show_chart,
            ),
            ZakatTextField(
              label: AppTranslations.getText('mutual_funds'),
              controller: _mutualFundsController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.pie_chart,
            ),
            ZakatTextField(
              label: AppTranslations.getText('bonds'),
              controller: _bondsController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.receipt_long,
            ),
            ZakatTextField(
              label: AppTranslations.getText('property_invest'),
              controller: _propertyInvestController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.apartment,
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
          colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
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
                  AppTranslations.getText('shares'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('shares'),
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppTranslations.getText('shares_description'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('shares_description'),
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
          currentValue:
              '$currency ${AppTranslations.formatNumber(_totalInvestment)}',
        ),
        const SizedBox(height: 15),
        ZakatResultCard(
          title: AppTranslations.getText('total_value'),
          value: '$currency ${AppTranslations.formatNumber(_totalInvestment)}',
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF1976D2),
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
