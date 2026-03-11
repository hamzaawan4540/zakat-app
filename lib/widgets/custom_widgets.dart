import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zakatoon/constants/translations.dart';

class ZakatStyles {
  static TextStyle getTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    required String text,
    bool isTitle = false,
  }) {
    return GoogleFonts.reemKufi(
      fontSize: fontSize ?? (isTitle ? 22 : 16),
      fontWeight: fontWeight ?? (isTitle ? FontWeight.bold : FontWeight.normal),
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}

class ZakatTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? suffix;
  final IconData? prefixIcon;
  final TextEditingController controller;

  const ZakatTextField({
    super.key,
    required this.label,
    this.hint,
    this.suffix,
    this.prefixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        cursorColor: theme.colorScheme.primary,
        keyboardType: TextInputType.number,
        style: ZakatStyles.getTextStyle(text: controller.text),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixText: suffix,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: theme.colorScheme.primary)
              : null,
          filled: true,
          fillColor: isDark ? const Color(0xFF252D27) : Colors.white,
          labelStyle: ZakatStyles.getTextStyle(
            text: label,
            color: isDark
                ? theme.colorScheme.secondary
                : theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          hintStyle: ZakatStyles.getTextStyle(
            text: hint ?? '',
            color: Colors.grey,
            fontSize: 14,
          ),
          suffixStyle: ZakatStyles.getTextStyle(
            text: suffix ?? '',
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.withAlpha(51)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }
}

class ZakatResultCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final bool isHighlighted;

  const ZakatResultCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = isHighlighted
        ? const Color(0xFF1A5F2C)
        : (iconColor ??
              (isDark ? theme.colorScheme.secondary : theme.primaryColor));

    return Container(
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
        border: isHighlighted
            ? Border.all(color: accentColor.withAlpha(100), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ZakatStyles.getTextStyle(
                    text: title,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                Text(
                  value,
                  style: ZakatStyles.getTextStyle(
                    text: value,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF252D27)
            : theme.colorScheme.primary.withAlpha(13),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(51)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ZakatStyles.getTextStyle(
                    text: title,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: ZakatStyles.getTextStyle(
                    text: content,
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NisabStatusWidget extends StatelessWidget {
  final bool nisabReached;
  final String nisabValue;
  final String currentValue;

  const NisabStatusWidget({
    super.key,
    required this.nisabReached,
    required this.nisabValue,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusText = nisabReached
        ? AppTranslations.getText('nisab_reached')
        : AppTranslations.getText('nisab_not_reached');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: nisabReached
            ? (isDark
                  ? theme.colorScheme.primary.withAlpha(40)
                  : theme.colorScheme.primary.withAlpha(25))
            : (isDark ? Colors.orange.withAlpha(40) : const Color(0xFFFFF3E0)),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: nisabReached
              ? theme.colorScheme.primary.withAlpha(76)
              : const Color(0xFFFF9800).withAlpha(76),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: nisabReached
                  ? theme.colorScheme.primary.withAlpha(51)
                  : const Color(0xFFFF9800).withAlpha(51),
              shape: BoxShape.circle,
            ),
            child: Icon(
              nisabReached ? Icons.check_circle : Icons.info,
              color: nisabReached
                  ? (isDark
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.primary)
                  : const Color(0xFFFF9800),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: ZakatStyles.getTextStyle(
                    text: statusText,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: nisabReached
                        ? (isDark
                              ? theme.colorScheme.secondary
                              : theme.colorScheme.primary)
                        : const Color(0xFFFF9800),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppTranslations.getText('nisab_label')}: $nisabValue',
                  style: ZakatStyles.getTextStyle(
                    text: AppTranslations.getText('nisab_label'),
                    fontSize: 12,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ZakatStyles.getTextStyle(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: ZakatStyles.getTextStyle(
                text: subtitle!,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ZakatCalculateButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const ZakatCalculateButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          text,
          style: ZakatStyles.getTextStyle(
            text: text,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A5F2C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}

class ZakatCategoryCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final String description;
  final Color gradientStart;
  final Color gradientEnd;
  final VoidCallback onTap;

  const ZakatCategoryCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.description,
    required this.gradientStart,
    required this.gradientEnd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientStart.withAlpha(76),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withAlpha(60)
                            : Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        iconPath,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.7),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withAlpha(204),
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
