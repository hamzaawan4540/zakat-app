import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_widgets.dart';
import '../constants/translations.dart';

class LivestockZakatScreen extends StatefulWidget {
  const LivestockZakatScreen({super.key});

  @override
  State<LivestockZakatScreen> createState() => _LivestockZakatScreenState();
}

class _LivestockZakatScreenState extends State<LivestockZakatScreen> {
  int _selectedTab = 0;
  final _goatController = TextEditingController();
  final _cowController = TextEditingController();
  final _camelController = TextEditingController();

  String _goatZakat = '';
  String _cowZakat = '';
  String _camelZakat = '';

  void _calculateGoatZakat() {
    int count = int.tryParse(_goatController.text) ?? 0;
    if (count < 40) {
      _goatZakat = AppTranslations.getText(
        'no_zakat_nisab',
      ).replaceFirst('{count}', '40');
    } else if (count <= 120) {
      _goatZakat = '1 ${AppTranslations.getText('goat')}';
    } else if (count <= 200) {
      _goatZakat = '2 ${AppTranslations.getText('goats')}';
    } else if (count <= 399) {
      _goatZakat = '3 ${AppTranslations.getText('goats')}';
    } else {
      int zakat = count ~/ 100;
      _goatZakat = '$zakat ${AppTranslations.getText('goats')}';
    }
    setState(() {});
  }

  void _calculateCowZakat() {
    int count = int.tryParse(_cowController.text) ?? 0;
    if (count < 30) {
      _cowZakat = AppTranslations.getText(
        'no_zakat_nisab',
      ).replaceFirst('{count}', '30');
    } else if (count <= 39) {
      _cowZakat = '1 ${AppTranslations.getText('tabi')}';
    } else if (count <= 59) {
      _cowZakat = '1 ${AppTranslations.getText('musinnah')}';
    } else if (count <= 69) {
      _cowZakat = '2 ${AppTranslations.getText('tabi')}';
    } else if (count <= 79) {
      _cowZakat =
          '1 ${AppTranslations.getText('musinnah')} + 1 ${AppTranslations.getText('tabi')}';
    } else {
      _cowZakat = '2 ${AppTranslations.getText('musinnah')}';
    }
    setState(() {});
  }

  void _calculateCamelZakat() {
    int count = int.tryParse(_camelController.text) ?? 0;
    if (count < 5) {
      _camelZakat = AppTranslations.getText(
        'no_zakat_nisab',
      ).replaceFirst('{count}', '5');
    } else if (count <= 9) {
      _camelZakat = '1 ${AppTranslations.getText('goat')}';
    } else if (count <= 14) {
      _camelZakat = '2 ${AppTranslations.getText('goats')}';
    } else if (count <= 19) {
      _camelZakat = '3 ${AppTranslations.getText('goats')}';
    } else if (count <= 24) {
      _camelZakat = '4 ${AppTranslations.getText('goats')}';
    } else if (count <= 35) {
      _camelZakat = '1 ${AppTranslations.getText('bint_makhad')}';
    } else {
      _camelZakat = '1 ${AppTranslations.getText('bint_labun')}';
    }
    setState(() {});
  }

  @override
  void dispose() {
    _goatController.dispose();
    _cowController.dispose();
    _camelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('livestock'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('livestock'),
            fontWeight: FontWeight.bold,
            isTitle: true,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            _buildAnimalTabs(),
            const SizedBox(height: 25),
            _buildCalculatorView(),
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
          colors: [Color(0xFF795548), Color(0xFF5D4037)],
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
              'assets/svg icons/cow.svg',
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
                  AppTranslations.getText('livestock'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('livestock'),
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppTranslations.getText('livestock_description'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('livestock_description'),
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

  Widget _buildAnimalTabs() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252D27) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _buildTabItem(
            0,
            'assets/svg icons/goat.svg',
            AppTranslations.getText('goat_sheep'),
          ),
          _buildTabItem(
            1,
            'assets/svg icons/cow.svg',
            AppTranslations.getText('cow_buffalo'),
          ),
          _buildTabItem(
            2,
            'assets/svg icons/camel.svg',
            AppTranslations.getText('camel'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, dynamic icon, String title) {
    bool selected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF795548) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              icon is String && icon.endsWith('.svg')
                  ? SvgPicture.asset(icon, width: 24, height: 24)
                  : Text(icon.toString(), style: const TextStyle(fontSize: 20)),
              Text(
                title,
                style: ZakatStyles.getTextStyle(
                  text: title,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculatorView() {
    switch (_selectedTab) {
      case 0:
        return _buildCalculator(
          AppTranslations.getText('goat_sheep'),
          'assets/goat.png',
          _goatController,
          _calculateGoatZakat,
          _goatZakat,
          [
            ['40-120', '1 Goat'],
            ['121-200', '2 Goats'],
            ['201-399', '3 Goats'],
            ['400+', '1 Goat per 100'],
          ],
        );
      case 1:
        return _buildCalculator(
          AppTranslations.getText('cow_buffalo'),
          'assets/cow.png',
          _cowController,
          _calculateCowZakat,
          _cowZakat,
          [
            ['30-39', '1 Tabi (1 yr)'],
            ['40-59', '1 Musinnah (2 yr)'],
            ['60-69', '2 Tabi'],
            ['70+', '1 Musinnah + 1 Tabi'],
          ],
        );
      case 2:
        return _buildCalculator(
          AppTranslations.getText('camel'),
          'assets/camel.png',
          _camelController,
          _calculateCamelZakat,
          _camelZakat,
          [
            ['5-9', '1 Goat'],
            ['10-14', '2 Goats'],
            ['15-19', '3 Goats'],
            ['20-24', '4 Goats'],
            ['25-35', '1 Bint Makhad'],
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildCalculator(
    String title,
    String image,
    TextEditingController controller,
    VoidCallback onCalc,
    String result,
    List<List<String>> rules,
  ) {
    return Column(
      children: [
        SectionHeader(
          title: '${AppTranslations.getText('enter_details')} ($title)',
        ),
        ZakatTextField(
          label: AppTranslations.getText('animal_count'),
          controller: controller,
          suffix: AppTranslations.getText('count'),
          prefixIcon: Icons.pets,
        ),
        const SizedBox(height: 10),
        ZakatCalculateButton(
          text: AppTranslations.getText('calculate'),
          icon: Icons.calculate,
          onPressed: onCalc,
        ),
        if (result.isNotEmpty) ...[
          const SizedBox(height: 25),
          ZakatResultCard(
            title: AppTranslations.getText('zakat_due'),
            value: result,
            icon: Icons.volunteer_activism,
            isHighlighted: true,
          ),
        ],
        const SizedBox(height: 25),
        SectionHeader(title: AppTranslations.getText('zakat_rule')),
        _buildRulesTable(rules),
      ],
    );
  }

  Widget _buildRulesTable(List<List<String>> rules) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252D27) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withAlpha(51)),
      ),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey.withAlpha(51),
          borderRadius: BorderRadius.circular(15),
        ),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xFF795548).withAlpha(25),
            ),
            children: [
              _buildTableCell(
                AppTranslations.getText('animal_count'),
                isHeader: true,
              ),
              _buildTableCell(
                AppTranslations.getText('zakat_due'),
                isHeader: true,
              ),
            ],
          ),
          ...rules.map(
            (rule) => TableRow(
              children: [_buildTableCell(rule[0]), _buildTableCell(rule[1])],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: ZakatStyles.getTextStyle(
          text: text,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 14 : 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
