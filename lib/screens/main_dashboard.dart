import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zakatoon/constants/translations.dart';
import 'home_screen.dart';
import 'tasbeeh_screen.dart';
import 'islamic_calendar_screen.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TasbeehScreen(),
    const IslamicCalendarScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF1A5F2C);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Main Content extends behind the navigation bar
          Positioned.fill(
            child: IndexedStack(index: _selectedIndex, children: _screens),
          ),

          // Floating Navigation Bar Overlay
          Positioned(
            left: 20,
            right: 20,
            bottom: 35,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E2520) : Colors.white,
                borderRadius: BorderRadius.circular(20), // Reduced radius
                border: Border.all(
                  color: isDark ? Colors.white10 : primaryColor.withAlpha(30),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 100 : 40),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Reduced radius
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      0,
                      'assets/svg icons/home.svg',
                      AppTranslations.getText('home'),
                      primaryColor,
                    ),
                    _buildNavItem(
                      1,
                      'assets/svg icons/summary.svg', // Assuming summary or similar for tasbeeh if no specific exists, or use default if needed. USER asked to put svg.
                      AppTranslations.getText('tasbeeh'),
                      primaryColor,
                    ),
                    _buildNavItem(
                      2,
                      'assets/svg icons/calender.svg',
                      AppTranslations.getText('calendar'),
                      primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String svgPath,
    String label,
    Color primaryColor,
  ) {
    final isSelected = _selectedIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        scale: isSelected ? 1.2 : 1.0,
        curve: Curves.easeOutBack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: isSelected ? 1.0 : 0.6,
              child: SvgPicture.asset(svgPath, width: 24, height: 24),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? primaryColor
                    : (isDark ? Colors.white38 : Colors.grey.shade600),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
