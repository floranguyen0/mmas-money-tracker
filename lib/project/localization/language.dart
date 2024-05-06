class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;
  final String countryCode;
  final String currencySymbol;
  final String currencyCode;
  final String currencyName;
  const Language(
      this.id,
      this.flag,
      this.name,
      this.languageCode,
      this.countryCode,
      this.currencySymbol,
      this.currencyCode,
      this.currencyName);
  static List<Language> languageList = [
    Language(
        1, "🇺🇸", "English", "en", 'US', '\$', 'USD', 'United States Dollar'),
    // Language(2, "🇸🇦", "العربية", "ar", 'SA', 'R'),
    Language(3, "🇩🇪", "Deutsch", "de", 'DE', '€', 'EUR', 'Euro'),
    Language(4, "🇪🇸", "Español", "es", 'ES', '€', 'EUR', 'Euro'),
    Language(5, "🇫🇷", "Français", "fr", 'FR', '€', 'EUR', 'Euro'),
    Language(6, "🇮🇳", "हिन्दी", "hi", 'IN', '₹', 'INR', 'Indian Rupee'),
    Language(7, "🇯🇵", "日本語", "ja", 'JP', '¥', 'JPY', 'Japanese Yen'),
    Language(8, "🇰🇷", "한국어", "ko", 'KR', '₩', 'KRW', 'South Korean Won'),
    Language(9, "🇵🇹", "Português", "pt", 'PT', '€', 'EUR', 'Euro'),
    Language(
        10, "🇷🇺", "Русский язык", "ru", 'RU', 'руб', 'RUB', 'Russian Ruble'),
    Language(11, "🇹🇷", "Türkçe", "tr", 'TR', 'TL', 'TRY', 'Turkish Lira'),
    Language(
        12, "🇻🇳", "Tiếng Việt", "vi", 'VN', '₫', 'VND', 'Vietnamese Dong'),
    Language(13, "🇨🇳", "中文", "zh", 'CN', '¥', 'CNY', 'Chinese Yuan'),
        Language(14, "🇳🇵", "नेपाली", "ne", 'NP', 'रु', 'NPR', 'Nepali Rupee'),
  ];
}
