// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zakatoon/constants/translations.dart';
import '../widgets/custom_widgets.dart';

class TotalZakatScreen extends StatelessWidget {
  final double goldZakat;
  final double silverZakat;
  final double cashZakat;
  final double businessZakat;
  final double agricultureZakat;
  final double livestockZakat;
  final VoidCallback onClear;

  const TotalZakatScreen({
    super.key,
    required this.goldZakat,
    required this.silverZakat,
    required this.cashZakat,
    required this.businessZakat,
    required this.agricultureZakat,
    required this.livestockZakat,
    required this.onClear,
  });

  double get totalZakat =>
      goldZakat +
      silverZakat +
      cashZakat +
      businessZakat +
      agricultureZakat +
      livestockZakat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('total_summary'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('total_summary'),
            fontWeight: FontWeight.bold,
            isTitle: true,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/svg icons/delete.svg', width: 24),
            color: Colors.white,
            onPressed: () => _confirmClear(context),
            tooltip: AppTranslations.getText('clear_all'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTotalCard(),
            if (totalZakat > 0) ...[
              const SizedBox(height: 25),
              _buildChartSection(context),
            ],
            const SizedBox(height: 25),
            SectionHeader(title: AppTranslations.getText('zakat_breakdown')),
            const SizedBox(height: 10),
            _buildItem(
              context,
              'gold',
              goldZakat,
              'assets/svg icons/gold.svg',
              Colors.amber,
            ),
            _buildItem(
              context,
              'silver',
              silverZakat,
              'assets/svg icons/silver.svg',
              Colors.grey,
            ),
            _buildItem(
              context,
              'cash',
              cashZakat,
              'assets/svg icons/cash.svg',
              Colors.green,
            ),
            _buildItem(
              context,
              'business',
              businessZakat,
              'assets/svg icons/business.svg',
              Colors.brown,
            ),
            _buildItem(
              context,
              'agriculture',
              agricultureZakat,
              'assets/svg icons/agriculture.svg',
              Colors.lightGreen,
            ),
            _buildItem(
              context,
              'livestock',
              livestockZakat,
              'assets/svg icons/cow.svg',
              Colors.deepOrange,
            ),
            const SizedBox(height: 30),
            _buildInfoCard(),
            const SizedBox(height: 30),
            ZakatCalculateButton(
              text: AppTranslations.getText('share_summary'),
              icon: Icons.share,
              onPressed: () => _shareZakatSummary(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppTranslations.getText('confirm_clear')),
        content: Text(AppTranslations.getText('clear_desc')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppTranslations.getText('cancel')),
          ),
          TextButton(
            onPressed: () {
              onClear();
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back home
            },
            child: Text(
              AppTranslations.getText('clear_all'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D3B19), Color(0xFF1A5F2C), Color(0xFF2E7D32)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(51),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            AppTranslations.getText('total_zakat'),
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Rs. ',
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppTranslations.formatNumber(totalZakat),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              AppTranslations.getText('annual_obligation'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252D27) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: PieChart(
        PieChartData(
          sectionsSpace: 5,
          centerSpaceRadius: 40,
          sections: [
            if (goldZakat > 0)
              _buildChartSectionData('gold', goldZakat, Colors.amber),
            if (silverZakat > 0)
              _buildChartSectionData('silver', silverZakat, Colors.grey),
            if (cashZakat > 0)
              _buildChartSectionData('cash', cashZakat, Colors.green),
            if (businessZakat > 0)
              _buildChartSectionData('business', businessZakat, Colors.brown),
            if (agricultureZakat > 0)
              _buildChartSectionData(
                'agriculture',
                agricultureZakat,
                Colors.lightGreen,
              ),
            if (livestockZakat > 0)
              _buildChartSectionData(
                'livestock',
                livestockZakat,
                Colors.deepOrange,
              ),
          ],
        ),
      ),
    );
  }

  PieChartSectionData _buildChartSectionData(
    String key,
    double amount,
    Color color,
  ) {
    return PieChartSectionData(
      color: color,
      value: amount,
      title: '${(amount / totalZakat * 100).toStringAsFixed(0)}%',
      radius: 60,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String key,
    double amount,
    String iconPath,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252D27) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withAlpha(50) : color.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(iconPath, width: 20, height: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTranslations.getText(key),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText(key),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  AppTranslations.getText('${key}_description'),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            'Rs. ${AppTranslations.formatNumber(amount)}',
            style: ZakatStyles.getTextStyle(
              text: '0',
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return InfoCard(
      title: AppTranslations.getText('important_note'),
      content: AppTranslations.getText('advice_text'),
      icon: Icons.lightbulb_outline,
    );
  }

  void _shareZakatSummary() {
    String summary = "${AppTranslations.getText('zakat_summary_title')}\n\n";
    if (goldZakat > 0) {
      summary += "Gold: Rs. ${AppTranslations.formatNumber(goldZakat)}\n";
    }
    if (silverZakat > 0) {
      summary += "Silver: Rs. ${AppTranslations.formatNumber(silverZakat)}\n";
    }
    if (cashZakat > 0) {
      summary += "Cash: Rs. ${AppTranslations.formatNumber(cashZakat)}\n";
    }
    if (businessZakat > 0) {
      summary +=
          "Business: Rs. ${AppTranslations.formatNumber(businessZakat)}\n";
    }
    if (agricultureZakat > 0) {
      summary +=
          "Agriculture: Rs. ${AppTranslations.formatNumber(agricultureZakat)}\n";
    }
    if (livestockZakat > 0) {
      summary +=
          "Livestock: Rs. ${AppTranslations.formatNumber(livestockZakat)}\n";
    }
    summary += "\n----------------------\n";
    summary += "Total Zakat: Rs. ${AppTranslations.formatNumber(totalZakat)}\n";
    summary += "----------------------\n\n";
    summary += AppTranslations.getText('may_allah_accept');

    Share.share(summary);
  }
}
