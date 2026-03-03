// Zakat Data Models

class ZakatItem {
  final String category;
  final String description;
  final double value;
  final double zakatAmount;

  ZakatItem({
    required this.category,
    required this.description,
    required this.value,
    required this.zakatAmount,
  });
}

class GoldZakatData {
  final double totalGrams;
  final double totalTola;
  final double ratePerGram;
  final double ratePerTola;
  final double totalValue;
  final double zakatAmount;
  final bool nisabReached;

  GoldZakatData({
    required this.totalGrams,
    required this.totalTola,
    required this.ratePerGram,
    required this.ratePerTola,
    required this.totalValue,
    required this.zakatAmount,
    required this.nisabReached,
  });
}

class SilverZakatData {
  final double totalGrams;
  final double totalTola;
  final double ratePerGram;
  final double ratePerTola;
  final double totalValue;
  final double zakatAmount;
  final bool nisabReached;

  SilverZakatData({
    required this.totalGrams,
    required this.totalTola,
    required this.ratePerGram,
    required this.ratePerTola,
    required this.totalValue,
    required this.zakatAmount,
    required this.nisabReached,
  });
}

class CashZakatData {
  final double cashInHand;
  final double bankBalance;
  final double savings;
  final double totalAmount;
  final double zakatAmount;
  final bool nisabReached;

  CashZakatData({
    required this.cashInHand,
    required this.bankBalance,
    required this.savings,
    required this.totalAmount,
    required this.zakatAmount,
    required this.nisabReached,
  });
}

class BusinessZakatData {
  final double inventory;
  final double receivables;
  final double cashInBusiness;
  final double payables;
  final double netAssets;
  final double zakatAmount;
  final bool nisabReached;

  BusinessZakatData({
    required this.inventory,
    required this.receivables,
    required this.cashInBusiness,
    required this.payables,
    required this.netAssets,
    required this.zakatAmount,
    required this.nisabReached,
  });
}

class AgricultureZakatData {
  final String cropType;
  final double quantity; // in kg or maund
  final double pricePerUnit;
  final double totalValue;
  final bool isIrrigated; // true = 5%, false = 10%
  final double ushrAmount;

  AgricultureZakatData({
    required this.cropType,
    required this.quantity,
    required this.pricePerUnit,
    required this.totalValue,
    required this.isIrrigated,
    required this.ushrAmount,
  });
}

enum LivestockType { goat, cow, camel }

class LivestockZakatData {
  final LivestockType type;
  final int count;
  final int zakatCount;
  final String zakatDescription;
  final bool nisabReached;

  LivestockZakatData({
    required this.type,
    required this.count,
    required this.zakatCount,
    required this.zakatDescription,
    required this.nisabReached,
  });
}

class TotalZakatSummary {
  final double goldZakat;
  final double silverZakat;
  final double cashZakat;
  final double businessZakat;
  final double agricultureZakat;
  final double livestockValue;
  final double sharesZakat;
  final double totalZakat;

  TotalZakatSummary({
    required this.goldZakat,
    required this.silverZakat,
    required this.cashZakat,
    required this.businessZakat,
    required this.agricultureZakat,
    required this.livestockValue,
    required this.sharesZakat,
    required this.totalZakat,
  });
}
