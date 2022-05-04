import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';

import 'category_item.dart';
import 'input_model.dart';

Color green = Color.fromRGBO(57, 157, 3, 1),
    red = Color.fromRGBO(217, 89, 89, 1),
    white = Color.fromRGBO(255, 255, 255, 1),
    blue1 = Color.fromRGBO(210, 234, 251, 1),
    blue2 = Color.fromRGBO(139, 205, 254, 1),
    blue3 = Color.fromRGBO(89, 176, 222, 1),
    grey = Colors.grey;

List<Color> chartPieColors = [
  //19
  Color.fromRGBO(100, 202, 254, 1),
  Color.fromRGBO(80, 157, 253, 1),
  Color.fromRGBO(7, 156, 193, 1),
  Color.fromRGBO(89, 129, 163, 1),
  Color.fromRGBO(79, 94, 120, 1),
  Color.fromRGBO(196, 199, 216, 1),
  Color.fromRGBO(255, 206, 161, 1),
  Color.fromRGBO(255, 183, 121, 1),
  Color.fromRGBO(237, 156, 128, 1),
  Color.fromRGBO(126, 180, 166, 1),
  Color.fromRGBO(212, 216, 140, 1),
  Color.fromRGBO(144, 192, 106, 1),
  Color.fromRGBO(128, 186, 76, 1),
  Color.fromRGBO(224, 217, 255, 1),
  Color.fromRGBO(202, 164, 255, 1),
  Color.fromRGBO(197, 156, 240, 1),
  Color.fromRGBO(241, 197, 211, 1),
  Color.fromRGBO(244, 151, 178, 1),
  Color.fromRGBO(218, 145, 176, 1),
  //20
  Color.fromRGBO(141, 190, 255, 1),
  Color.fromRGBO(160, 217, 254, 1),
  Color.fromRGBO(117, 216, 228, 1),
  Color.fromRGBO(120, 217, 192, 1),
  Color.fromRGBO(172, 198, 152, 1),
  Color.fromRGBO(162, 193, 115, 1),
  Color.fromRGBO(112, 164, 112, 1),
  Color.fromRGBO(65, 174, 223, 1),
  Color.fromRGBO(71, 131, 192, 1),
  Color.fromRGBO(32, 225, 188, 1),
  Color.fromRGBO(53, 136, 143, 1),
  Color.fromRGBO(139, 178, 193, 1),
  Color.fromRGBO(125, 150, 191, 1),
  Color.fromRGBO(119, 131, 148, 1),
  Color.fromRGBO(243, 210, 122, 1),
  Color.fromRGBO(254, 203, 94, 1),
  Color.fromRGBO(244, 186, 106, 1),
  Color.fromRGBO(217, 165, 105, 1),
  Color.fromRGBO(214, 142, 96, 1),
  Color.fromRGBO(190, 119, 112, 1),
  Color.fromRGBO(194, 94, 78, 1),
  Color.fromRGBO(192, 72, 42, 1),
  Color.fromRGBO(176, 29, 51, 1),
//18
  Color.fromRGBO(198, 180, 251, 1),
  Color.fromRGBO(155, 128, 217, 1),
  Color.fromRGBO(112, 130, 212, 1),
  Color.fromRGBO(78, 123, 216, 1),
  Color.fromRGBO(139, 205, 254, 1),
  Color.fromRGBO(89, 176, 222, 1),
  Color.fromRGBO(81, 155, 194, 1),
  Color.fromRGBO(4, 135, 192, 1),
  Color.fromRGBO(50, 128, 171, 1),
  Color.fromRGBO(44, 110, 119, 1),
  Color.fromRGBO(41, 147, 134, 1),
  Color.fromRGBO(95, 155, 71, 1),
  Color.fromRGBO(179, 217, 37, 1),
  Color.fromRGBO(237, 178, 135, 1),
  Color.fromRGBO(198, 157, 100, 1),
  Color.fromRGBO(194, 140, 112, 1),
  Color.fromRGBO(214, 138, 88, 1),
  Color.fromRGBO(225, 123, 66, 1),
];

String format(double number) =>
    NumberFormat("#,###,###,###,###,###.##", "en_US").format(number);

IconData iconData(CategoryItem item) => IconData(item.iconCodePoint,
    fontPackage: item.iconFontPackage, fontFamily: item.iconFontFamily);

//should description be '' or null?
CategoryItem categoryItem(IconData icon, String name) =>
    CategoryItem(icon.codePoint, icon.fontPackage, icon.fontFamily, name, '');

Widget? connectionUI(AsyncSnapshot<List<InputModel>> snapshot) {
  if (snapshot.connectionState == ConnectionState.none) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  if (snapshot.hasError) {
    print('${snapshot.error}');
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

List<CategoryItem> createItemList({
  List<InputModel>? transactions,
  required bool forAnalysisPage,
  isIncomeType,
  forSelectIconPage,
}) {
  List<CategoryItem> itemList = [], items = [], expenseItems = [];
  sharedPrefs.getAllExpenseItemsLists().forEach((parentExpenseItem) =>
      parentExpenseItem
          .forEach((expenseItem) => expenseItems.add(expenseItem)));

  if (forAnalysisPage) {
    items = isIncomeType ? incomeItems : expenseItems;
  } else {
    items = [...incomeItems, ...expenseItems];
  }
  if (forSelectIconPage) {
    return items;
  } else {
    for (InputModel transaction in transactions!) {
      for (int i = 0; i < items.length; i++) {
        if (transaction.category == items[i].text) {
          itemList.add(items[i]);
          break;
        }
        if (i == items.length - 1) {
          CategoryItem itemElse = CategoryItem(
              Icons.category_outlined.codePoint,
              Icons.category_outlined.fontPackage,
              Icons.category_outlined.fontFamily,
              transaction.category!,
              transaction.description);
          itemList.add(itemElse);
        }
      }
    }
    return itemList;
  }
}

//for analysis, report

final DateTime now = DateTime.now(),
    todayDT = DateTime(now.year, now.month, now.day),
    startOfThisWeek = todayDT.subtract(Duration(days: todayDT.weekday - 1)),
    startOfThisMonth = DateTime(todayDT.year, todayDT.month, 1),
    startOfThisYear = DateTime(todayDT.year, 1, 1),
    startOfThisQuarter = DateTime(todayDT.year, quarterStartMonth, 1);

final int thisQuarter = (todayDT.month + 2) ~/ 3,
    quarterStartMonth = 3 * thisQuarter - 2;
final List<String> timeline = [
  'Today',
  'This week',
  'This month',
  'This quarter',
  'This year',
  'All'
];

InputModel inputModel(data) => InputModel(
    id: data.id,
    type: data.type,
    amount: data.amount!,
    category: data.category!,
    description: data.description!,
    date: data.date,
    time: data.time);

List<InputModel> filterData(
    BuildContext context, List<InputModel> data, String selectedDate) {
  // filter data based on user's selected day
  return (data
          .map((data) {
            DateTime dateSelectedDT =
                DateFormat('dd/MM/yyyy').parse(data.date!);

            if (selectedDate == 'Today') {
              if (dateSelectedDT.isAfter(todayDT.subtract(Duration(days: 1))) &&
                  dateSelectedDT.isBefore(todayDT.add(Duration(days: 1)))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This week') {
              if (dateSelectedDT
                      .isAfter(startOfThisWeek.subtract(Duration(days: 1))) &&
                  dateSelectedDT
                      .isBefore(startOfThisWeek.add(Duration(days: 7)))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This month') {
              if (dateSelectedDT
                      .isAfter(startOfThisMonth.subtract(Duration(days: 1))) &&
                  dateSelectedDT
                      .isBefore(DateTime(todayDT.year, todayDT.month + 1, 1))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This quarter') {
              if (dateSelectedDT.isAfter(
                      startOfThisQuarter.subtract(Duration(days: 1))) &&
                  dateSelectedDT.isBefore(DateTime(startOfThisQuarter.year,
                      startOfThisQuarter.month + 3, 1))) {
                return inputModel(data);
              }
            } else if (selectedDate == 'This year') {
              if (dateSelectedDT
                      .isAfter(startOfThisYear.subtract(Duration(days: 1))) &&
                  dateSelectedDT.isBefore(DateTime(todayDT.year + 1, 1, 1))) {
                return inputModel(data);
              }
            } else {
              return inputModel(data);
            }
          })
          .where((element) => element != null)
          .toList())
      .cast<InputModel>();
}

// //3
// Color.fromRGBO(97, 162, 195, 1),
// Color.fromRGBO(107, 203, 253, 1),
// //2
// Color.fromRGBO(241, 187, 140, 1),
// Color.fromRGBO(242, 193, 145, 1),
// Color.fromRGBO(241, 197, 161, 1),
// Color.fromRGBO(227, 191, 145, 1),
// Color.fromRGBO(241, 207, 170, 1),
// Color.fromRGBO(151, 209, 255, 1),
// Color.fromRGBO(238, 161, 130, 1),
// Color.fromRGBO(253, 152, 67, 1),
// Color.fromRGBO(11, 153, 178, 1),
// Color.fromRGBO(5, 168, 192, 1),
// //
// Color.fromRGBO( 35, 115, 217, 1),
// Color.fromRGBO(6, 104, 189, 1),
// Color.fromRGBO( 45, 99, 186, 1),
// Color.fromRGBO( 61, 122, 135, 1),
// Color.fromRGBO( 42, 65, 88, 1),
// Color.fromRGBO(36, 85, 120, 1),
// Color.fromRGBO(57, 63, 71, 1),
// Color.fromRGBO(20, 44, 90, 1),
// Color.fromRGBO(27, 114, 181, 1),
// Color.fromRGBO(72, 102, 164, 1),
// Color.fromRGBO( 24, 47, 66, 1),
// Color.fromRGBO(56, 78, 116, 1),
// Color.fromRGBO(101, 70, 163, 1),
// Color.fromRGBO(78, 45, 127, 1),
// Color.fromRGBO(116, 13, 64, 1),
// Color.fromRGBO(83, 92, 112, 1),
// Color.fromRGBO(79, 168, 169, 1),
// Color.fromRGBO(60, 186, 177, 1),
// Color.fromRGBO( 47, 178, 196, 1),
// Color.fromRGBO( 68, 165, 193, 1),
// Color.fromRGBO(50, 101, 114, 1),
// Color.fromRGBO(2, 67, 107, 1),
// Color.fromRGBO(57, 68, 99, 1),
// Color.fromRGBO(65, 96, 142, 1),
// Color.fromRGBO(78, 123, 165, 1),
// Color.fromRGBO(95, 114, 138, 1),
// Color.fromRGBO(218, 60, 81, 1),
// Color.fromRGBO(52, 92, 67, 1),
// Color.fromRGBO(69, 91, 50, 1),
// Color.fromRGBO(71, 90, 44, 1),
// Color.fromRGBO(252, 182, 35, 1),
// Color.fromRGBO(255, 201, 0, 1),
// Color.fromRGBO(254, 190, 48, 1),
// Color.fromRGBO(241, 87, 33, 1),
// Color.fromRGBO(255, 122, 0, 1),
// Color.fromRGBO(215, 122, 2, 1),
// Color.fromRGBO(176, 99, 52, 1),
// Color.fromRGBO(190, 100, 42, 1),
// Color.fromRGBO(166, 120, 73, 1),
// Color.fromRGBO(165, 116, 81, 1),
// Color.fromRGBO(161, 85, 244, 1),
// Color.fromRGBO(162, 74, 125, 1),
// Color.fromRGBO(156, 41, 134, 1),
// Color.fromRGBO(153, 51, 178, 1),
// Color.fromRGBO(233, 114, 228, 1),
// Color.fromRGBO(158, 20, 24, 1),
// Color.fromRGBO(203, 71, 242, 1),
// Color.fromRGBO(218, 91, 160, 1),
// Color.fromRGBO(181, 89, 171, 1),
// Color.fromRGBO(208, 80, 135, 1),
// Color.fromRGBO(2, 157, 193, 1),
// Color.fromRGBO(34, 146, 212, 1),
// Color.fromRGBO(2, 205, 209, 1),
// Color.fromRGBO(85, 16, 9, 1),
// Color.fromRGBO(196, 238, 236, 1),
// Color.fromRGBO(192, 243, 247, 1),
// Color.fromRGBO(164, 255, 242, 1),
// Color.fromRGBO(248, 233, 193, 1),
// Color.fromRGBO(244, 231, 203, 1),
// Color.fromRGBO(212, 228, 244, 1),
// Color.fromRGBO(188, 235, 239, 1),
// Color.fromRGBO(246, 192, 142, 1),
// Color.fromRGBO(233, 242, 235, 1),
// Color.fromRGBO(227, 191, 145, 1),
// Color.fromRGBO(189, 79, 0, 1),
// Color.fromRGBO(214, 89, 43, 1),
// Color.fromRGBO(240, 105, 85, 1),
// Color.fromRGBO(231, 116, 46, 1),
// Color.fromRGBO(156, 89, 98, 1),
// Color.fromRGBO(208, 151, 99, 1),
// Color.fromRGBO(189, 124, 66, 1),
// Color.fromRGBO(181, 116, 67, 1),
// Color.fromRGBO(242, 135, 36, 1),
// Color.fromRGBO(243, 129, 61, 1),
// Color.fromRGBO(240, 131, 36, 1),
// Color.fromRGBO(245, 139, 46, 1),
// Color.fromRGBO(254, 160, 51, 1),
// Color.fromRGBO(239, 156, 71, 1),
// Color.fromRGBO(245, 166, 76, 1),
// Color.fromRGBO(245, 164, 52, 1),
// Color.fromRGBO(243, 170, 48, 1),
// Color.fromRGBO(164, 148, 126, 1),
// Color.fromRGBO(190, 157, 116, 1),
// Color.fromRGBO(191, 164, 131, 1),
// Color.fromRGBO(192, 176, 160, 1),
// Color.fromRGBO(193, 177, 164, 1),
// Color.fromRGBO(214, 193, 165, 1),
// Color.fromRGBO(255, 221, 206, 1),
// Color.fromRGBO(242, 217, 203, 1),
// Color.fromRGBO(245, 236, 224, 1),
// Color.fromRGBO(255, 232, 204, 1),
// Color.fromRGBO(255, 246, 216, 1),
// Color.fromRGBO(157, 245, 255, 1),
// Color.fromRGBO(235, 128, 209, 1),
// Color.fromRGBO(194, 212, 241, 1),
// Color.fromRGBO(196, 222, 235, 1),
// Color.fromRGBO(160, 224, 239, 1),
// Color.fromRGBO(157, 231, 244, 1),
// Color.fromRGBO(127, 191, 239, 1),
// Color.fromRGBO(214, 213, 155, 1),
// Color.fromRGBO(229, 217, 147, 1),
// Color.fromRGBO(208, 185, 240, 1),
// Color.fromRGBO(204, 217, 224, 1),
// Color.fromRGBO(168, 196, 187, 1),
// Color.fromRGBO(198, 219, 207, 1),
// Color.fromRGBO(203, 214, 189, 1),
// Color.fromRGBO(213, 245, 206, 1),
// Color.fromRGBO(186, 183, 168, 1),
// Color.fromRGBO(218, 214, 211, 1),
// Color.fromRGBO(218, 200, 182, 1),
// Color.fromRGBO(182, 168, 165, 1),
// Color.fromRGBO(214, 193, 165, 1),
// Color.fromRGBO(183, 205, 164, 1),
// Color.fromRGBO(159, 198, 127, 1),
// Color.fromRGBO(143, 165, 124, 1),
// Color.fromRGBO(126, 165, 147, 1),
// Color.fromRGBO(124, 188, 49, 1),
// Color.fromRGBO(148, 245, 183, 1),
// Color.fromRGBO(110, 145, 80, 1),
// Color.fromRGBO(115, 137, 78, 1),
// Color.fromRGBO(122, 138, 3, 1),
// Color.fromRGBO(209, 182, 73, 1),
// Color.fromRGBO(90, 138, 11, 1),
// Color.fromRGBO(54, 167, 92, 1),
// Color.fromRGBO(137, 224, 208, 1),
// Color.fromRGBO(150, 166, 191, 1),
// Color.fromRGBO(153, 168, 177, 1),
// Color.fromRGBO(160, 174, 179, 1),
// Color.fromRGBO(25, 200, 255, 1),
// Color.fromRGBO(0, 234, 245, 1),
// Color.fromRGBO(141, 7, 0, 1),
// Color.fromRGBO(104, 15, 28, 1),
// Color.fromRGBO(237, 254, 243, 1),
// Color.fromRGBO(22, 207, 152, 1),
