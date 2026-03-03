import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zakatoon/constants/translations.dart';
import '../widgets/custom_widgets.dart';

class ZakatGuideScreen extends StatelessWidget {
  const ZakatGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppTranslations.getText('zakat_guide'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('zakat_guide'),
            fontWeight: FontWeight.bold,
            isTitle: true,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroCard(),
            const SizedBox(height: 25),
            SectionHeader(title: AppTranslations.getText('who_receive_zakat')),
            _buildRecipientList(),
            const SizedBox(height: 25),
            SectionHeader(
              title: AppTranslations.getText('items_subject_zakat'),
            ),
            _buildItemsList(context),
            const SizedBox(height: 25),
            SectionHeader(title: AppTranslations.getText('faqs')),
            _buildFAQ(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D3B19), Color(0xFF1A5F2C)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/svg icons/zakat_guide.svg',
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 10),
          Text(
            AppTranslations.getText('what_is_zakat'),
            style: ZakatStyles.getTextStyle(
              text: AppTranslations.getText('what_is_zakat'),
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              isTitle: true,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppTranslations.getText('zakat_intro'),
            textAlign: TextAlign.center,
            style: ZakatStyles.getTextStyle(
              text: AppTranslations.getText('zakat_intro'),
              color: Colors.white.withAlpha(200),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientList() {
    final recipients = [
      {
        'title': 'Al-Fuqara',
        'desc': 'The poor who have some money but not enough for basics.',
      },
      {'title': 'Al-Masakin', 'desc': 'The destitute who have nothing at all.'},
      {
        'title': 'Al-Amiline',
        'desc': 'Those who are appointed to collect/distribute Zakat.',
      },
      {
        'title': 'Al-Mu’allafat Qulubuhum',
        'desc': 'To reconcile people’s hearts (new Muslims).',
      },
      {
        'title': 'Ar-Riqaab',
        'desc': 'For the emancipation of slaves or captives.',
      },
      {
        'title': 'Al-Gharimine',
        'desc': 'Those who are in debt and cannot pay back.',
      },
      {
        'title': 'Fi-Sabilillah',
        'desc': 'In the path of Allah (for those striving for Islam).',
      },
      {
        'title': 'Ibnu’s-Sabil',
        'desc': 'The wayfarer (travelers cut off from their wealth).',
      },
    ];

    return Column(
      children: recipients
          .map((r) => _buildRecipientItem(r['title']!, r['desc']!))
          .toList(),
    );
  }

  Widget _buildRecipientItem(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green.withAlpha(13),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.withAlpha(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A5F2C),
            ),
          ),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildItemsList(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = [
      {'icon': 'assets/svg icons/gold.svg', 'title': 'Gold & Silver'},
      {'icon': 'assets/svg icons/cash.svg', 'title': 'Cash & Savings'},
      {'icon': 'assets/svg icons/summary.svg', 'title': 'Business & Stocks'},
      {
        'icon': 'assets/svg icons/agriculture.svg',
        'title': 'Agricultural Crops',
      },
      {'icon': 'assets/svg icons/cow.svg', 'title': 'Livestock Animals'},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items
          .map(
            (i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF252D27) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withAlpha(51)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(i['icon']!, width: 20, height: 20),
                  const SizedBox(width: 8),
                  Text(
                    i['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildFAQ() {
    final faqs = [
      {
        'q': 'When should Zakat be paid?',
        'a':
            'Zakat is due once a full lunar year (Hawl) has passed on wealth possessed above the Nisab.',
      },
      {
        'q': 'Is Zakat due on personal house?',
        'a':
            'No, Zakat is not due on personal property used for living, like your house or car.',
      },
      {
        'q': 'Who is eligible to receive Zakat?',
        'a':
            'The eight categories mentioned in the Quran, specifically including the poor and needy.',
      },
    ];

    return Column(
      children: faqs.map((f) => _buildFAQItem(f['q']!, f['a']!)).toList(),
    );
  }

  Widget _buildFAQItem(String q, String a) {
    return ExpansionTile(
      title: Text(
        q,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A5F2C),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            a,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
