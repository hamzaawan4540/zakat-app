import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_widgets.dart';
import '../constants/app_constants.dart';
import '../constants/translations.dart';

class SilverZakatScreen extends StatefulWidget {
  const SilverZakatScreen({super.key});

  @override
  State<SilverZakatScreen> createState() => _SilverZakatScreenState();
}

class _SilverZakatScreenState extends State<SilverZakatScreen> {
  final TextEditingController _silverTolaController = TextEditingController();
  final TextEditingController _silverGramController = TextEditingController();
  final TextEditingController _silverRateController = TextEditingController();

  bool _useTola = true;
  double _totalValue = 0;
  double _zakatAmount = 0;
  bool _nisabReached = false;
  bool _showResults = false;

  @override
  void dispose() {
    _silverTolaController.dispose();
    _silverGramController.dispose();
    _silverRateController.dispose();
    super.dispose();
  }

  void _calculateZakat() {
    double silverAmount = 0;
    double rate = double.tryParse(_silverRateController.text) ?? 0;

    if (_useTola) {
      silverAmount = double.tryParse(_silverTolaController.text) ?? 0;
      _totalValue = silverAmount * rate;
      _nisabReached = silverAmount >= ZakatConstants.silverNisabTola;
    } else {
      silverAmount = double.tryParse(_silverGramController.text) ?? 0;
      rate = rate / 11.664;
      _totalValue = silverAmount * rate;
      _nisabReached = silverAmount >= ZakatConstants.silverNisabGrams;
    }

    _zakatAmount = _nisabReached
        ? _totalValue * (ZakatConstants.zakatRate / 100)
        : 0;
    setState(() => _showResults = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('silver'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('silver'),
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
            _buildUnitToggle(),
            const SizedBox(height: 25),
            SectionHeader(title: AppTranslations.getText('enter_details')),
            _useTola
                ? ZakatTextField(
                    label:
                        '${AppTranslations.getText('silver_weight')} (${AppTranslations.getText('tola')})',
                    controller: _silverTolaController,
                    suffix: AppTranslations.getText('tola'),
                    prefixIcon: Icons.scale,
                  )
                : ZakatTextField(
                    label:
                        '${AppTranslations.getText('silver_weight')} (${AppTranslations.getText('grams')})',
                    controller: _silverGramController,
                    suffix: AppTranslations.getText('grams'),
                    prefixIcon: Icons.scale,
                  ),
            ZakatTextField(
              label: AppTranslations.getText('price_per_tola'),
              controller: _silverRateController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.currency_exchange,
            ),
            const SizedBox(height: 10),
            InfoCard(
              title: AppTranslations.getText('nisab_silver'),
              content: AppTranslations.getText('about_zakat_desc'),
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
          colors: [Color(0xFF9E9E9E), Color(0xFF757575)],
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
              'assets/svg icons/silver.svg',
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
                  AppTranslations.getText('silver'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('silver'),
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nisab: ${ZakatConstants.silverNisabTola} Tola',
                  style: ZakatStyles.getTextStyle(
                    text: 'Nisab',
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

  Widget _buildUnitToggle() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252D27) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _buildToggleItem(true, AppTranslations.getText('tola')),
          _buildToggleItem(false, AppTranslations.getText('grams')),
        ],
      ),
    );
  }

  Widget _buildToggleItem(bool isTola, String title) {
    bool selected = _useTola == isTola;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _useTola = isTola),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF9E9E9E) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: ZakatStyles.getTextStyle(
                text: title,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    return Column(
      children: [
        NisabStatusWidget(
          nisabReached: _nisabReached,
          nisabValue:
              '${ZakatConstants.silverNisabTola} ${AppTranslations.getText('tola')}',
          currentValue: _useTola
              ? '${_silverTolaController.text} ${AppTranslations.getText('tola')}'
              : '${_silverGramController.text} ${AppTranslations.getText('grams')}',
        ),
        const SizedBox(height: 15),
        ZakatResultCard(
          title: AppTranslations.getText('total_value'),
          value: 'Rs. ${AppTranslations.formatNumber(_totalValue)}',
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF9E9E9E),
        ),
        const SizedBox(height: 15),
        ZakatResultCard(
          title: AppTranslations.getText('zakat_payable'),
          value: 'Rs. ${AppTranslations.formatNumber(_zakatAmount)}',
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
