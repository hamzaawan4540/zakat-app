// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_widgets.dart';
import 'gold_zakat_screen.dart';
import 'silver_zakat_screen.dart';
import 'cash_zakat_screen.dart';
import 'business_zakat_screen.dart';
import 'agriculture_zakat_screen.dart';
import 'livestock_zakat_screen.dart';
import 'zakat_guide_screen.dart';
import 'total_zakat_screen.dart';
import 'islamic_calendar_screen.dart';
import '../constants/translations.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Store zakat values for total calculation
  double goldZakat = 0;
  double silverZakat = 0;
  double cashZakat = 0;
  double businessZakat = 0;
  double agricultureZakat = 0;
  double livestockZakat = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      goldZakat = prefs.getDouble('goldZakat') ?? 0;
      silverZakat = prefs.getDouble('silverZakat') ?? 0;
      cashZakat = prefs.getDouble('cashZakat') ?? 0;
      businessZakat = prefs.getDouble('businessZakat') ?? 0;
      agricultureZakat = prefs.getDouble('agricultureZakat') ?? 0;
      livestockZakat = prefs.getDouble('livestockZakat') ?? 0;
    });
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = themeNotifier.value == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    await prefs.setBool('isDarkMode', !isDark);
    themeNotifier.value = newMode;
    setState(() {}); // Rebuild local toggle icons
  }

  Future<void> _saveZakatData(String category, double amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${category}Zakat', amount);
  }

  Future<void> _clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      goldZakat = 0;
      silverZakat = 0;
      cashZakat = 0;
      businessZakat = 0;
      agricultureZakat = 0;
      livestockZakat = 0;
    });
  }

  void updateZakat(String category, double amount) {
    setState(() {
      switch (category) {
        case 'gold':
          goldZakat = amount;
          break;
        case 'silver':
          silverZakat = amount;
          break;
        case 'cash':
          cashZakat = amount;
          break;
        case 'business':
          businessZakat = amount;
          break;
        case 'agriculture':
          agricultureZakat = amount;
          break;
        case 'livestock':
          livestockZakat = amount;
          break;
      }
    });
    _saveZakatData(category, amount);
  }

  double get totalZakat =>
      goldZakat +
      silverZakat +
      cashZakat +
      businessZakat +
      agricultureZakat +
      livestockZakat;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF0D3B19), const Color(0xFF134E23)]
                        : [const Color(0xFF1A5F2C), const Color(0xFF2E7D32)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(isDark ? 100 : 40),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () =>
                              _scaffoldKey.currentState?.openDrawer(),
                        ),
                        // App Logo/Title Center
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppTranslations.getText('app_name'),
                                style: ZakatStyles.getTextStyle(
                                  text: AppTranslations.getText('app_name'),
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  isTitle: true,
                                ),
                              ),
                              Text(
                                AppTranslations.getText('app_subtitle'),
                                style: ZakatStyles.getTextStyle(
                                  text: AppTranslations.getText('app_subtitle'),
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(204),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 48,
                        ), // Padding to keep title centered
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Total Zakat Card
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TotalZakatScreen(
                              goldZakat: goldZakat,
                              silverZakat: silverZakat,
                              cashZakat: cashZakat,
                              businessZakat: businessZakat,
                              agricultureZakat: agricultureZakat,
                              livestockZakat: livestockZakat,
                              onClear: _clearAllData,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(isDark ? 20 : 30),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xFFD4AF37).withAlpha(100),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(30),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppTranslations.getText('total_zakat'),
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(204),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Rs. ',
                                      style: TextStyle(
                                        color: Color(0xFFD4AF37),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      AppTranslations.formatNumber(totalZakat),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD4AF37),
                                    Color(0xFFF4D03F),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SvgPicture.asset(
                                'assets/svg icons/arrow_forword.svg',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTranslations.getText('categories'),
                      style: ZakatStyles.getTextStyle(
                        text: AppTranslations.getText('categories'),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFFD4AF37)
                            : const Color(0xFF1A5F2C),
                      ),
                    ),
                    Text(
                      '${totalZakat > 0 ? 'Update' : 'Start'} Calculating',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.05,
                ),
                delegate: SliverChildListDelegate([
                  ZakatCategoryCard(
                    title: AppTranslations.getText('gold'),
                    iconPath: 'assets/svg icons/gold.svg',
                    description: AppTranslations.getText('gold_description'),
                    gradientStart: const Color(0xFFD4AF37),
                    gradientEnd: const Color(0xFFB8860B),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GoldZakatScreen(),
                        ),
                      );
                      if (result != null) {
                        updateZakat('gold', result);
                      }
                    },
                  ),
                  ZakatCategoryCard(
                    title: AppTranslations.getText('silver'),
                    iconPath: 'assets/svg icons/silver.svg',
                    description: AppTranslations.getText('silver_description'),
                    gradientStart: const Color(0xFF9E9E9E),
                    gradientEnd: const Color(0xFF757575),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SilverZakatScreen(),
                        ),
                      );
                      if (result != null) {
                        updateZakat('silver', result);
                      }
                    },
                  ),
                  ZakatCategoryCard(
                    title: AppTranslations.getText('cash'),
                    iconPath: 'assets/svg icons/cash.svg',
                    description: AppTranslations.getText('cash_description'),
                    gradientStart: const Color(0xFF2E7D32),
                    gradientEnd: const Color(0xFF1B5E20),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CashZakatScreen(),
                        ),
                      );
                      if (result != null) {
                        updateZakat('cash', result);
                      }
                    },
                  ),
                  ZakatCategoryCard(
                    title: AppTranslations.getText('business'),
                    iconPath: 'assets/svg icons/business.svg',
                    description: AppTranslations.getText(
                      'business_description',
                    ),
                    gradientStart: const Color(0xFF5D4037),
                    gradientEnd: const Color(0xFF3E2723),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BusinessZakatScreen(),
                        ),
                      );
                      if (result != null) {
                        updateZakat('business', result);
                      }
                    },
                  ),
                  ZakatCategoryCard(
                    title: AppTranslations.getText('agriculture'),
                    iconPath: 'assets/svg icons/agriculture.svg',
                    description: AppTranslations.getText(
                      'agriculture_description',
                    ),
                    gradientStart: const Color(0xFF8BC34A),
                    gradientEnd: const Color(0xFF689F38),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AgricultureZakatScreen(),
                        ),
                      );
                      if (result != null) {
                        updateZakat('agriculture', result);
                      }
                    },
                  ),
                  ZakatCategoryCard(
                    title: AppTranslations.getText('livestock'),
                    iconPath: 'assets/svg icons/cow.svg',
                    description: AppTranslations.getText(
                      'livestock_description',
                    ),
                    gradientStart: const Color(0xFF795548),
                    gradientEnd: const Color(0xFF5D4037),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LivestockZakatScreen(),
                        ),
                      );
                      if (result != null && result is double) {
                        updateZakat('livestock', result);
                      }
                    },
                  ),
                ]),
              ),
            ),

            // Info Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              const Color(0xFFD4AF37).withAlpha(25),
                              const Color(0xFFD4AF37).withAlpha(13),
                            ]
                          : [
                              const Color(0xFF1A5F2C).withAlpha(25),
                              const Color(0xFF1A5F2C).withAlpha(13),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFFD4AF37).withAlpha(51)
                          : const Color(0xFF1A5F2C).withAlpha(51),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: isDark
                                ? const Color(0xFFD4AF37)
                                : const Color(0xFF1A5F2C),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppTranslations.getText('about_zakat'),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? const Color(0xFFD4AF37)
                                  : const Color(0xFF1A5F2C),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppTranslations.getText('about_zakat_desc'),
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white70 : Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          _buildInfoChip(AppTranslations.getText('nisab_gold')),
                          const SizedBox(width: 10),
                          _buildInfoChip(
                            AppTranslations.getText('nisab_silver'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildInfoChip(AppTranslations.getText('zakat_rate')),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D3B19), Color(0xFF1A5F2C)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/app_logo.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppTranslations.getText('app_name'),
                    style: ZakatStyles.getTextStyle(
                      text: AppTranslations.getText('app_name'),
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      isTitle: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg icons/business.svg',
              width: 24,
            ),
            title: Text(
              AppTranslations.getText('view_summary'),
              style: ZakatStyles.getTextStyle(
                text: AppTranslations.getText('view_summary'),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TotalZakatScreen(
                    goldZakat: goldZakat,
                    silverZakat: silverZakat,
                    cashZakat: cashZakat,
                    businessZakat: businessZakat,
                    agricultureZakat: agricultureZakat,
                    livestockZakat: livestockZakat,
                    onClear: _clearAllData,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg icons/zakat_guide.svg',
              width: 24,
            ),
            title: Text(
              AppTranslations.getText('zakat_guide'),
              style: ZakatStyles.getTextStyle(
                text: AppTranslations.getText('zakat_guide'),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ZakatGuideScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg icons/calender.svg',
              width: 24,
            ),
            title: Text(
              AppTranslations.getText('islamic_calendar'),
              style: ZakatStyles.getTextStyle(
                text: AppTranslations.getText('islamic_calendar'),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IslamicCalendarScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, child) {
              final isDark = mode == ThemeMode.dark;
              return ListTile(
                leading: SvgPicture.asset(
                  'assets/svg icons/dark_mode.svg',
                  width: 24,
                ),
                title: Text(
                  AppTranslations.getText('dark_mode'),
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('dark_mode'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(
                  value: isDark,
                  activeColor: const Color(0xFFD4AF37),
                  onChanged: (value) => _toggleTheme(),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg icons/delete.svg',
              color: Colors.red,
              width: 24,
            ),
            title: Text(
              AppTranslations.getText('clear_all'),
              style: ZakatStyles.getTextStyle(
                text: AppTranslations.getText('clear_all'),
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _clearAllData();
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'v1.0.0',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withAlpha(13) : Colors.black.withAlpha(13),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: isDark ? Colors.white70 : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
