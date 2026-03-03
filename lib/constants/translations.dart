class AppTranslations {
  static Map<String, String> translations = {
    'app_name': 'Zakatoon',
    'app_subtitle': 'Zakat Calculator',
    'home': 'Home',
    'tasbeeh': 'Tasbeeh',
    'calendar': 'Calendar',
    'subhanallah': 'SubhanAllah',
    'alhamdulillah': 'Alhamdulillah',
    'allahuakbar': 'Allahu Akbar',
    'astaghfirullah': 'Astaghfirullah',
    'categories': 'Categories',
    'gold': 'Gold',
    'silver': 'Silver',
    'cash': 'Cash & Bank',
    'business': 'Business',
    'agriculture': 'Agriculture',
    'livestock': 'Livestock',
    'shares': 'Shares & Investments',
    'view_summary': 'View Summary',
    'zakat_guide': 'Zakat Guide',
    'zakat_categories': 'Zakat Categories',
    'clear_all': 'Clear All Data',
    'language': 'Language',
    'islamic_calendar': 'Islamic Calendar',
    'total_zakat': 'Total Zakat Due',
    'calculate': 'Calculate Zakat',
    'save': 'Save',
    'save_go_back': 'Save & Go Back',
    'cancel': 'Cancel',
    'about_zakat': 'About Zakat',
    'about_zakat_desc':
        'Zakat is one of the Five Pillars of Islam. It is obligatory for every Muslim who possesses wealth above the Nisab (minimum threshold) for a complete lunar year.',
    'nisab_gold': '7.5 Tola (87.48g)',
    'nisab_silver': '52.5 Tola (612.36g)',
    'zakat_rate': 'Zakat Rate: 2.5%',
    'appearance': 'Appearance',
    'dark_mode': 'Dark Mode',
    'light_mode': 'Light Mode',
    'total_summary': 'Total Zakat Summary',
    'zakat_breakdown': 'Zakat Breakdown',
    'annual_obligation': 'Annual Obligation',
    'may_allah_accept': 'May Allah accept your Zakat',
    'important_note': 'Important Note',
    'zakat_distribution': 'Zakat Distribution',
    'share_summary': 'Share Summary',
    'what_is_zakat': 'What is Zakat?',
    'zakat_intro':
        'Zakat is the third pillar of Islam. It is a compulsory act of worship that requires Muslims to donate a portion of their wealth to the needy.',
    'who_receive_zakat': 'Who should receive Zakat?',
    'items_subject_zakat': 'Items subject to Zakat',
    'faqs': 'Frequently Asked Questions',
    'gold_silver': 'Gold & Silver',
    'confirm_clear': 'Clear All Data?',
    'clear_desc': 'This will reset all your Zakat calculations to zero.',

    'gold_description': 'Zakat on gold jewelry',
    'silver_description': 'Zakat on silver items',
    'cash_description': 'Cash in hand & bank',
    'business_description': 'Trade goods & inventory',
    'agriculture_description': 'Ushr on crops & produce',
    'livestock_description': 'Goats, cows & camels',
    'shares_description': 'Stocks, funds & property',

    // Calculator Screens
    'enter_details': 'Enter Details',
    'gold_weight': 'Gold Weight',
    'silver_weight': 'Silver Weight',
    'price_per_tola': 'Price (per Tola)',
    'price_per_gram': 'Price (per Gram)',
    'tola': 'Tola',
    'grams': 'Grams',
    'results': 'Results',
    'total_value': 'Total Value',
    'nisab_status': 'Nisab Status',
    'nisab_reached': 'Nisab Reached ✅',
    'nisab_not_reached': 'Nisab Not Reached ❌',
    'nisab_label': 'Nisab',
    'zakat_payable': 'Zakat Payable',
    'currency': 'Rs.',
    'pkr': 'PKR',
    'crore': 'Cr',
    'lakh': 'Lac',

    'cash_in_hand': 'Cash in Hand',
    'bank_balance': 'Bank Balance',
    'savings': 'Savings',
    'committee': 'Committee',
    'loan_given': 'Loan Given',

    'inventory': 'Inventory / Stock',
    'receivables': 'Receivables',
    'payables': 'Payables / Debts',

    'crop_quantity': 'Crop Quantity',
    'price_per_unit': 'Price per Unit',
    'irrigated': 'Irrigated (5%)',
    'rain_fed': 'Rain-fed (10%)',
    'ushr_payable': 'Ushr Payable',
    'wheat': 'Wheat',
    'rice': 'Rice',
    'cotton': 'Cotton',
    'maize': 'Maize',
    'sugarcane': 'Sugarcane',
    'others': 'Others',

    'goat_sheep': 'Goats / Sheep',
    'cow_buffalo': 'Cows / Buffaloes',
    'camel': 'Camels',
    'animal_count': 'Number of Animals',
    'count': 'Count',
    'zakat_rule': 'Zakat Rule',
    'goat': 'Goat',
    'goats': 'Goats',
    'cow': 'Cow',
    'cows': 'Cows',
    'camel_animal': 'Camel',
    'camels': 'Camels',
    'tabi': 'Tabi (1 year old calf)',
    'musinnah': 'Musinnah (2 year old)',
    'bint_makhad': 'Bint Makhad (1 year camel)',
    'bint_labun': 'Bint Labun (2 year camel)',
    'no_zakat_nisab': 'No Zakat (Nisab: {count})',
    'zakat_due': 'Zakat Due',

    'shares_value': 'Stock / Shares Value',
    'mutual_funds': 'Mutual Funds',
    'bonds': 'Sukuk / Islamic Bonds',
    'property_invest': 'Property Investment',

    'zakat_summary_title': 'Zakatoon - Zakat Summary',
    'distribution_label': 'Zakat Distribution',
    'advice_text':
        'Zakat should be paid as soon as possible once it becomes obligatory. It is recommended to distribute Zakat locally to deserving individuals.',
  };

  static String getText(String key) {
    return translations[key] ?? key;
  }

  static String formatNumber(double n) {
    if (n >= 10000000) {
      return '${(n / 10000000).toStringAsFixed(2)} ${getText('crore')}';
    }
    if (n >= 100000) {
      return '${(n / 100000).toStringAsFixed(2)} ${getText('lakh')}';
    }
    return n.toStringAsFixed(0);
  }
}
