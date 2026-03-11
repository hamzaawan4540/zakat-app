import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../constants/translations.dart';
import '../main.dart'; // For themeNotifier
import '../screens/total_zakat_screen.dart';
import '../screens/zakat_guide_screen.dart';
import '../screens/islamic_calendar_screen.dart';
import 'custom_widgets.dart';

class AppDrawer extends StatelessWidget {
  final double goldZakat;
  final double silverZakat;
  final double cashZakat;
  final double businessZakat;
  final double agricultureZakat;
  final double livestockZakat;
  final VoidCallback onClear;
  final VoidCallback onThemeToggled;

  const AppDrawer({
    super.key,
    required this.goldZakat,
    required this.silverZakat,
    required this.cashZakat,
    required this.businessZakat,
    required this.agricultureZakat,
    required this.livestockZakat,
    required this.onClear,
    required this.onThemeToggled,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final drawerIconColor = isDark
        ? Colors.white.withOpacity(0.5)
        : Colors.grey.shade800;

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
              colorFilter: ColorFilter.mode(drawerIconColor, BlendMode.srcIn),
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
                    onClear: onClear,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg icons/zakat_guide.svg',
              width: 24,
              colorFilter: ColorFilter.mode(drawerIconColor, BlendMode.srcIn),
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
              colorFilter: ColorFilter.mode(drawerIconColor, BlendMode.srcIn),
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
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : Colors.grey.shade800,
                    BlendMode.srcIn,
                  ),
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
                  onChanged: (value) => onThemeToggled(),
                ),
              );
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg icons/delete.svg',
              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
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
              onClear();
            },
          ),
          ListTile(
            leading: Icon(Icons.share_outlined, color: drawerIconColor),
            title: Text(
              'Share App',
              style: ZakatStyles.getTextStyle(
                text: 'Share App',
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              final packageInfo = await PackageInfo.fromPlatform();
              final packageName = packageInfo.packageName;
              Share.share(
                'Download now to calculate your Zakat accurately.\n\nhttps://play.google.com/store/apps/details?id=$packageName',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.star_border, color: drawerIconColor),
            title: Text(
              'Rate App',
              style: ZakatStyles.getTextStyle(
                text: 'Rate App',
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              final packageInfo = await PackageInfo.fromPlatform();
              final packageName = packageInfo.packageName;
              final uri = Uri.parse(
                'https://play.google.com/store/apps/details?id=$packageName',
              );

              try {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } catch (e) {
                // Ignore failure
              }
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
}
