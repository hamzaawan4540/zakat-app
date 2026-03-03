import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_widgets.dart';
import '../constants/app_constants.dart';
import '../constants/translations.dart';

class AgricultureZakatScreen extends StatefulWidget {
  const AgricultureZakatScreen({super.key});

  @override
  State<AgricultureZakatScreen> createState() => _AgricultureZakatScreenState();
}

class _AgricultureZakatScreenState extends State<AgricultureZakatScreen> {
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCrop = 'Wheat';
  bool _isIrrigated = false; // false = rain-fed (10%), true = irrigated (5%)
  double _totalValue = 0;
  double _ushrAmount = 0;
  bool _showResults = false;

  final List<String> _crops = [
    'Wheat',
    'Rice',
    'Cotton',
    'Sugarcane',
    'Maize',
    'Barley',
    'Vegetables',
    'Fruits',
    'Other',
  ];

  void _calculateUshr() {
    double quantity = double.tryParse(_quantityController.text) ?? 0;
    double price = double.tryParse(_priceController.text) ?? 0;

    _totalValue = quantity * price;
    double rate = _isIrrigated
        ? ZakatConstants.ushrRateSinchaiWali
        : ZakatConstants.ushrRateBaghair;
    _ushrAmount = _totalValue * (rate / 100);
    setState(() => _showResults = true);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('agriculture'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('agriculture'),
            fontWeight: FontWeight.bold,
            isTitle: true,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, _ushrAmount),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            SectionHeader(
              title: AppTranslations.getText('items_subject_zakat'),
            ),
            _buildCropDropdown(),
            const SizedBox(height: 20),
            SectionHeader(title: 'Irrigation Type'),
            _buildIrrigationToggle(),
            const SizedBox(height: 20),
            SectionHeader(title: AppTranslations.getText('enter_details')),
            ZakatTextField(
              label: AppTranslations.getText('crop_quantity'),
              controller: _quantityController,
              suffix: 'Maund',
              prefixIcon: Icons.scale,
            ),
            ZakatTextField(
              label: AppTranslations.getText('price_per_unit'),
              controller: _priceController,
              suffix: AppTranslations.getText('pkr'),
              prefixIcon: Icons.currency_exchange,
            ),
            const SizedBox(height: 10),
            InfoCard(
              title: 'Ushr Rate',
              content: _isIrrigated
                  ? 'For irrigated land, Ushr is 5% of the total produce.'
                  : 'For rain-fed or naturally watered land, Ushr is 10% of the total produce.',
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 25),
            ZakatCalculateButton(
              text: AppTranslations.getText('calculate'),
              icon: Icons.calculate,
              onPressed: _calculateUshr,
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
          colors: [Color(0xFF8BC34A), Color(0xFF689F38)],
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
              'assets/svg icons/agriculture.svg',
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
                  AppTranslations.getText('agriculture'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('agriculture'),
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppTranslations.getText('agriculture_description'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('agriculture_description'),
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

  Widget _buildCropDropdown() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252D27) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withAlpha(51)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCrop,
          isExpanded: true,
          dropdownColor: isDark ? const Color(0xFF1A1F1B) : Colors.white,
          onChanged: (String? newValue) {
            if (newValue != null) setState(() => _selectedCrop = newValue);
          },
          items: _crops.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: ZakatStyles.getTextStyle(
                  text: value,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildIrrigationToggle() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252D27) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _buildToggleItem(false, AppTranslations.getText('rain_fed')),
          _buildToggleItem(true, AppTranslations.getText('irrigated')),
        ],
      ),
    );
  }

  Widget _buildToggleItem(bool isIrrigated, String title) {
    bool selected = _isIrrigated == isIrrigated;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isIrrigated = isIrrigated),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF8BC34A) : Colors.transparent,
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
    String currency = AppTranslations.getText('currency');
    return Column(
      children: [
        ZakatResultCard(
          title: 'Produce Value',
          value: '$currency ${AppTranslations.formatNumber(_totalValue)}',
          icon: Icons.agriculture,
          iconColor: const Color(0xFF8BC34A),
        ),
        const SizedBox(height: 15),
        ZakatResultCard(
          title: AppTranslations.getText('ushr_payable'),
          value: '$currency ${AppTranslations.formatNumber(_ushrAmount)}',
          icon: Icons.volunteer_activism,
          isHighlighted: true,
        ),
        const SizedBox(height: 20),
        if (_ushrAmount > 0)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context, _ushrAmount),
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
