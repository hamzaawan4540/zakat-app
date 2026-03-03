// Zakat App Constants - Pakistan Context
// All nisab values are based on Islamic principles

class ZakatConstants {
  // Zakat Rate (2.5%)
  static const double zakatRate = 2.5;

  // Gold Nisab - 7.5 Tola (87.48 grams)
  static const double goldNisabTola = 7.5;
  static const double goldNisabGrams = 87.48;

  // Silver Nisab - 52.5 Tola (612.36 grams)
  static const double silverNisabTola = 52.5;
  static const double silverNisabGrams = 612.36;

  // Default rates (can be updated by user)
  // Gold rate per tola (PKR) - approximate current rate
  static const double defaultGoldRatePerTola = 280000;
  // Gold rate per gram (PKR)
  static const double defaultGoldRatePerGram = 24000;

  // Silver rate per tola (PKR)
  static const double defaultSilverRatePerTola = 3200;
  // Silver rate per gram (PKR)
  static const double defaultSilverRatePerGram = 274;

  // Agricultural Zakat Rates
  // Ushr - 10% if rain-fed (barani)
  static const double ushrRateBaghair = 10.0;
  // Nisf Ushr - 5% if irrigated
  static const double ushrRateSinchaiWali = 5.0;

  // Livestock Nisab
  // Goat/Sheep - minimum 40
  static const int goatNisab = 40;
  // Cow/Buffalo - minimum 30
  static const int cowNisab = 30;
  // Camel - minimum 5
  static const int camelNisab = 5;

  // App Theme Colors
  static const int primaryColorValue = 0xFF1A5F2C; // Islamic Green
  static const int secondaryColorValue = 0xFF2E7D32;
  static const int accentColorValue = 0xFFD4AF37; // Gold accent
  static const int backgroundColorValue = 0xFFF5F5F5;
  static const int cardColorValue = 0xFFFFFFFF;
  static const int darkGreenValue = 0xFF0D3B19;

  // Currency
  static const String currency = 'PKR';
  static const String currencySymbol = 'Rs.';
}

// Zakat Categories
enum ZakatCategory {
  gold,
  silver,
  cash,
  bankBalance,
  business,
  agriculture,
  livestock,
  shares,
  property,
}

class ZakatCategoryInfo {
  final String name;
  final String urduName;
  final String icon;
  final String description;

  const ZakatCategoryInfo({
    required this.name,
    required this.urduName,
    required this.icon,
    required this.description,
  });
}

final Map<ZakatCategory, ZakatCategoryInfo> zakatCategories = {
  ZakatCategory.gold: const ZakatCategoryInfo(
    name: 'Gold',
    urduName: 'سونا',
    icon: 'assets/svg icons/gold.svg',
    description: 'Zakat on gold jewelry and ornaments',
  ),
  ZakatCategory.silver: const ZakatCategoryInfo(
    name: 'Silver',
    urduName: 'چاندی',
    icon: 'assets/svg icons/silver.svg',
    description: 'Zakat on silver jewelry and items',
  ),
  ZakatCategory.cash: const ZakatCategoryInfo(
    name: 'Cash & Savings',
    urduName: 'نقد رقم',
    icon: 'assets/svg icons/cash.svg',
    description: 'Zakat on cash in hand and savings',
  ),
  ZakatCategory.bankBalance: const ZakatCategoryInfo(
    name: 'Bank Balance',
    urduName: 'بینک بیلنس',
    icon:
        'assets/svg icons/cash.svg', // Assuming bank is close to cash or use specific if available
    description: 'Zakat on bank deposits',
  ),
  ZakatCategory.business: const ZakatCategoryInfo(
    name: 'Business/Trade',
    urduName: 'کاروبار',
    icon: 'assets/svg icons/business.svg',
    description: 'Zakat on business inventory and trade goods',
  ),
  ZakatCategory.agriculture: const ZakatCategoryInfo(
    name: 'Agriculture',
    urduName: 'زراعت / فصل',
    icon: 'assets/svg icons/agriculture.svg',
    description: 'Ushr on agricultural produce',
  ),
  ZakatCategory.livestock: const ZakatCategoryInfo(
    name: 'Livestock',
    urduName: 'جانور',
    icon: 'assets/svg icons/cow.svg',
    description: 'Zakat on animals (goats, cows, camels)',
  ),
  ZakatCategory.shares: const ZakatCategoryInfo(
    name: 'Shares & Investments',
    urduName: 'حصص اور سرمایہ',
    icon: 'assets/svg icons/business.svg',
    description: 'Zakat on stocks and investments',
  ),
};
