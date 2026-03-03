import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_widgets.dart';
import '../constants/app_constants.dart';
import '../constants/translations.dart';

class CashZakatScreen extends StatefulWidget {
  const CashZakatScreen({super.key});

  @override
  State<CashZakatScreen> createState() => _CashZakatScreenState();
}

class _CashZakatScreenState extends State<CashZakatScreen> {
  final _cashController = TextEditingController();
  final _bankController = TextEditingController();
  final _savingsController = TextEditingController();
  final _committeeController = TextEditingController();
  final _loanGivenController = TextEditingController();

  double _totalAmount = 0;
  double _zakatAmount = 0;
  bool _nisabReached = false;
  bool _showResults = false;

  double get _nisabValue =>
      ZakatConstants.silverNisabTola * ZakatConstants.defaultSilverRatePerTola;

  void _calculateZakat() {
    double cash = double.tryParse(_cashController.text) ?? 0;
    double bank = double.tryParse(_bankController.text) ?? 0;
    double savings = double.tryParse(_savingsController.text) ?? 0;
    double committee = double.tryParse(_committeeController.text) ?? 0;
    double loanGiven = double.tryParse(_loanGivenController.text) ?? 0;

    _totalAmount = cash + bank + savings + committee + loanGiven;
    _nisabReached = _totalAmount >= _nisabValue;
    _zakatAmount = _nisabReached
        ? _totalAmount * (ZakatConstants.zakatRate / 100)
        : 0;
    setState(() => _showResults = true);
  }

  @override
  void dispose() {
    _cashController.dispose();
    _bankController.dispose();
    _savingsController.dispose();
    _committeeController.dispose();
    _loanGivenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('cash'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('cash'),
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
              label: AppTranslations.getText('cash_in_hand'),
              controller: _cashController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.money,
            ),
            ZakatTextField(
              label: AppTranslations.getText('bank_balance'),
              controller: _bankController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.account_balance,
            ),
            ZakatTextField(
              label: AppTranslations.getText('savings'),
              controller: _savingsController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.savings,
            ),
            ZakatTextField(
              label: AppTranslations.getText('committee'),
              controller: _committeeController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.groups,
            ),
            ZakatTextField(
              label: AppTranslations.getText('loan_given'),
              controller: _loanGivenController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.undo,
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
          colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
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
              'assets/svg icons/cash.svg',
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
                  AppTranslations.getText('cash'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('cash'),
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppTranslations.getText('cash_description'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('cash_description'),
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
              '$currency ${AppTranslations.formatNumber(_totalAmount)}',
        ),
        const SizedBox(height: 15),
        ZakatResultCard(
          title: AppTranslations.getText('total_value'),
          value: '$currency ${AppTranslations.formatNumber(_totalAmount)}',
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF2E7D32),
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
