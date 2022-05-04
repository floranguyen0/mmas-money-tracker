import 'package:flutter/cupertino.dart';
import 'package:money_assistant_2608/project/classes/category_item.dart';
import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';

import 'classes/input_model.dart';
import 'database_management/sqflite_services.dart';

// input
class ChangeCategoryA with ChangeNotifier {
  CategoryItem? categoryItemA;

  void changeCategory(CategoryItem? newItem) {
    categoryItemA = newItem ?? categoryItemA;
    notifyListeners();
  }
}

class ChangeModelType with ChangeNotifier {
  String? modelType;
  void changeModelType(String newType) {
    this.modelType = newType;
    notifyListeners();
  }
}

// analysis, report
class ChangeSelectedDate with ChangeNotifier {
  String? selectedAnalysisDate;
  String? selectedReportDate;
  void changeSelectedAnalysisDate({String? newSelectedDate}) {
    selectedAnalysisDate = newSelectedDate;
    notifyListeners();
  }

  void changeSelectedReportDate({String? newSelectedDate}) {
    selectedReportDate = newSelectedDate;
    notifyListeners();
  }
}

//report
class InputModelList with ChangeNotifier {
  Future<List<InputModel>> inputModelList = DB.inputModelList();
  void changeInputModelList() {
    inputModelList = DB.inputModelList();
    notifyListeners();
  }
}

//expense_category
class ChangeExpenseItem with ChangeNotifier {
  var exItemsLists = sharedPrefs.getAllExpenseItemsLists();
  void getAllExpenseItems() {
    exItemsLists = sharedPrefs.getAllExpenseItemsLists();
    notifyListeners();
  }
}

class ChangeExpenseItemEdit with ChangeNotifier {
  var exItemsLists = sharedPrefs.getAllExpenseItemsLists();
  void getAllExpenseItems() {
    exItemsLists = sharedPrefs.getAllExpenseItemsLists();
    notifyListeners();
  }
}

//income_category
class ChangeIncomeItem with ChangeNotifier {
  var incomeItems = sharedPrefs.getItems('income items');
  void getIncomeItems() {
    incomeItems = sharedPrefs.getItems('income items');
    notifyListeners();
  }
}

class ChangeIncomeItemEdit with ChangeNotifier {
  var incomeItems = sharedPrefs.getItems('income items');
  void getIncomeItems() {
    incomeItems = sharedPrefs.getItems('income items');
    notifyListeners();
  }
}

//add_category
class ChangeCategory with ChangeNotifier {
  IconData? selectedCategoryIcon;
  CategoryItem? parentItem;

  void changeCategoryIcon(IconData? selectedIcon) {
    this.selectedCategoryIcon = selectedIcon;
    notifyListeners();
  }

  void changeParentItem(CategoryItem? newParentItem) {
    parentItem = newParentItem ?? parentItem;
    notifyListeners();
  }
}

//other
class OnSwitch with ChangeNotifier {
  bool isPasscodeOn = sharedPrefs.isPasscodeOn;

  void onSwitch() {
    sharedPrefs.isPasscodeOn = !sharedPrefs.isPasscodeOn;
    isPasscodeOn = sharedPrefs.isPasscodeOn;
    notifyListeners();
  }
}

//select_language
class OnLanguageSelected with ChangeNotifier {
  String languageCode = sharedPrefs.getLocale().languageCode;
  void onSelect(String newLanguageCode) {
    languageCode = newLanguageCode;
    notifyListeners();
  }
}

//select_currency
class OnCurrencySelected with ChangeNotifier {
  String appCurrency = sharedPrefs.appCurrency;
  void onCurrencySelected(String newCurrency) {
    appCurrency = newCurrency;
    sharedPrefs.appCurrency = newCurrency;
    sharedPrefs.getCurrency();
    notifyListeners();
  }
}

//select_date_format
class OnDateFormatSelected with ChangeNotifier {
  String dateFormat = sharedPrefs.dateFormat;
  void onDateFormatSelected(String newDateFormat) {
    dateFormat = newDateFormat;
    sharedPrefs.dateFormat = newDateFormat;
    notifyListeners();
  }
}
