class CategoryItem {
  int iconCodePoint;
  String? iconFontPackage;
  String? iconFontFamily;
  String text;
  String? description;
  CategoryItem(this.iconCodePoint, this.iconFontPackage, this.iconFontFamily,
      this.text, this.description);

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return new CategoryItem(json['iconCodePoint'], json['iconFontPackage'],
        json['iconFontFamily'], json['text'], json['description']);
  }
  Map<String, dynamic> toJson() {
    return {
      'iconCodePoint': this.iconCodePoint,
      'iconFontPackage': this.iconFontPackage,
      'iconFontFamily': this.iconFontFamily,
      'text': this.text,
      'description': this.description
    };
  }
}
