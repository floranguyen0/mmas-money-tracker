import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:money_assistant_2608/project/classes/category_item.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = SharedPrefs();
// constants/strings.dart
// const String appCurrency = 'app_currency';
late String currency;
var incomeItems = sharedPrefs.getItems('income items');

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  sharePrefsInit() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get selectedDate => _sharedPrefs!.getString('selectedDate')!;

  set selectedDate(String value) {
    _sharedPrefs!.setString('selectedDate', value);
  }

  String get appCurrency =>
      _sharedPrefs!.getString('appCurrency') ?? Platform.localeName;

  set appCurrency(String appCurrency) =>
      _sharedPrefs!.setString('appCurrency', appCurrency);

  String get dateFormat =>
      _sharedPrefs!.getString('dateFormat') ?? 'dd/MM/yyyy';

  set dateFormat(String dateFormat) =>
      _sharedPrefs!.setString('dateFormat', dateFormat);


  bool get isPasscodeOn => _sharedPrefs!.getBool('isPasscodeOn') ?? false;

  set isPasscodeOn(bool value) => _sharedPrefs!.setBool('isPasscodeOn', value);

  String get passcodeScreenLock =>
      _sharedPrefs!.getString('passcodeScreenLock')!;

  set passcodeScreenLock(String value) =>
      _sharedPrefs!.setString('passcodeScreenLock', value);

  List<String> get parentExpenseItemNames =>
      _sharedPrefs!.getStringList('parent expense item names')!;

  // not yet use this set method
  set parentExpenseItemNames(List<String> parentExpenseItemNames) =>
      _sharedPrefs!
          .setStringList('parent expense item names', parentExpenseItemNames);

  Locale setLocale(String languageCode) {
    _sharedPrefs!.setString('languageCode', languageCode);
    return locale(languageCode);
  }

  Locale getLocale() {
    String languageCode = _sharedPrefs!.getString('languageCode') ?? "en";
    return locale(languageCode);
  }

  void getCurrency() {
    if (_sharedPrefs!.containsKey('appCurrency')) {
      var format = NumberFormat.simpleCurrency(locale: sharedPrefs.appCurrency);
      currency = format.currencySymbol;
    } else {
      var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
      currency = format.currencySymbol;
    }
  }

  //jsonEncode turns a Map<String, dynamic> into a json string,
  //jsonDecode turns a json string into a Map<String, dynamic>
  List<CategoryItem> getItems(String parentItemName) {
    List<String> itemsEncoded = _sharedPrefs!.getStringList(parentItemName)!;
    List<CategoryItem> items = itemsEncoded
        .map((item) => CategoryItem.fromJson(jsonDecode(item)))
        .toList();
    return items;
  }

  void saveItems(String parentItemName, List<CategoryItem> items) {
    List<String> itemsEncoded =
        items.map((item) => jsonEncode(item.toJson())).toList();

    _sharedPrefs!.setStringList(parentItemName, itemsEncoded);
  }

  List<List<CategoryItem>> getAllExpenseItemsLists() {
    List<List<CategoryItem>> expenseItemsLists = [];
    for (int i = 0; i < this.parentExpenseItemNames.length; i++) {
      var parentExpenseItem =
          sharedPrefs.getItems(this.parentExpenseItemNames[i]);
      expenseItemsLists.add(parentExpenseItem);
    }
    return expenseItemsLists;
  }

  void removeItem(String itemName) {
    _sharedPrefs!.remove(itemName);
  }

  void setItems({required bool setCategoriesToDefault}) {
    // _sharedPrefs!.clear();

    if (!_sharedPrefs!.containsKey('parent expense item names') ||
        setCategoriesToDefault) {
      _sharedPrefs!.setStringList('parent expense item names', [
        'Food & Beverages',
        'Transport',
        'Personal Development',
        'Shopping',
        'Entertainment',
        'Home',
        'Utility Bills',
        'Health',
        'Gifts & Donations',
        'Kids',
        'OtherExpense'
      ]);

      saveItems('income items', [
        categoryItem(MdiIcons.accountCash, 'Salary'),
        categoryItem(Icons.business_center_rounded, 'InvestmentIncome'),
        categoryItem(IcoFontIcons.moneyBag, 'Bonus'),
        categoryItem(IcoFontIcons.searchJob, 'Side job'),
        categoryItem(IcoFontIcons.gift, 'GiftsIncome'),
        categoryItem(MdiIcons.cashPlus, 'OtherIncome'),
      ]);

      saveItems('Food & Beverages', [
        categoryItem(MdiIcons.food, 'Food & Beverages'),
        categoryItem(MdiIcons.foodDrumstick, 'Food'),
        categoryItem(Icons.local_bar, 'Beverages'),
        categoryItem(Icons.add_shopping_cart, 'Daily Necessities'),
      ]);

      saveItems('Transport', [
        categoryItem(OMIcons.commute, 'Transport'),
        categoryItem(Icons.local_gas_station, 'Fuel'),
        categoryItem(Icons.local_parking, 'Parking'),
        categoryItem(IcoFontIcons.toolsBag, 'Services & Maintenance'),
        categoryItem(Icons.local_taxi_outlined, 'Taxi'),
      ]);

      saveItems('Personal Development', [
        categoryItem(IcoFontIcons.businessman, 'Personal Development'),
        categoryItem(Icons.business, 'Business'),
        categoryItem(IcoFontIcons.education, 'Education'),
        categoryItem(IcoFontIcons.bagAlt, 'InvestmentExpense'),
      ]);

      saveItems('Shopping', [
        categoryItem(IcoFontIcons.shoppingCart, 'Shopping'),
        categoryItem(Boxicons.bxs_t_shirt, 'Clothes'),
        categoryItem(Boxicons.bxs_binoculars, 'Accessories'),
        categoryItem(Boxicons.bxs_devices, 'Electronic Devices'),
      ]);

      saveItems('Entertainment', [
        categoryItem(Icons.add_photo_alternate_outlined, 'Entertainment'),
        categoryItem(Icons.movie_filter, 'Movies'),
        categoryItem(IcoFontIcons.gameController, 'Games'),
        categoryItem(Icons.library_music, 'Music'),
        categoryItem(Icons.airplanemode_active, 'Travel'),
      ]);

      saveItems('Home', [
        categoryItem(MdiIcons.homeHeart, 'Home'),
        categoryItem(MdiIcons.dogService, 'Pets'),
        categoryItem(MdiIcons.tableChair, 'Furnishings'),
        categoryItem(MdiIcons.autoFix, 'Home Services'),
        categoryItem(MdiIcons.homeCurrencyUsd, 'Mortgage & Rent'),
      ]);

      saveItems('Utility Bills', [
        categoryItem(FontAwesomeIcons.fileInvoiceDollar, 'Utility Bills'),
        categoryItem(IcoFontIcons.lightBulb, 'Electricity'),
        categoryItem(IcoFontIcons.globe, 'Internet'),
        categoryItem(IcoFontIcons.stockMobile, 'Mobile Phone'),
        categoryItem(IcoFontIcons.waterDrop, 'Water'),
      ]);

      saveItems('Health', [
        categoryItem(FontAwesomeIcons.handHoldingMedical, 'Health'),
        categoryItem(MdiIcons.soccer, 'Sports'),
        categoryItem(MdiIcons.fileDocumentMultipleOutline, 'Health Insurance'),
        categoryItem(MdiIcons.doctor, 'Doctor'),
        categoryItem(MdiIcons.medicalBag, 'Medicine'),
      ]);

      saveItems('Gifts & Donations', [
        categoryItem(Boxicons.bxs_donate_heart, 'Gifts & Donations'),
        categoryItem(IcoFontIcons.gift, 'GiftsExpense'),
        categoryItem(IcoFontIcons.love, 'Wedding'),
        categoryItem(IcoFontIcons.worried, 'Funeral'),
        categoryItem(IcoFontIcons.usersSocial, 'Charity'),
      ]);

      saveItems('Kids', [
        categoryItem(Icons.child_care, 'Kids'),
        categoryItem(MdiIcons.cashCheck, 'Pocket Money'),
        categoryItem(MdiIcons.babyBottle, 'Baby Products'),
        categoryItem(MdiIcons.humanBabyChangingTable, 'Babysitter & Daycare'),
        categoryItem(MdiIcons.bookCheck, 'Tuition'),
      ]);
      saveItems('OtherExpense', [
        categoryItem(MdiIcons.cashPlus, 'OtherExpense'),
      ]);
      if (!setCategoriesToDefault) {
        _sharedPrefs!.setString('selectedDate', 'Today');
        _sharedPrefs!.setBool('isPasscodeOn', false);
        _sharedPrefs!.setString('passcodeScreenLock', '');
        _sharedPrefs!.setString('dateFormat', 'dd/MM/yyyy');
      }
    }
    if (_sharedPrefs!.containsKey('parent expense item names') == false) {
      print('didnt save successfully');
    }
  }
}
