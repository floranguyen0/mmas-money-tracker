import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/app_bar.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:money_assistant_2608/project/provider.dart';
import 'package:provider/provider.dart';

import 'add_category.dart';
import 'edit_income_category.dart';

class IncomeCategory extends StatefulWidget {
  @override
  _IncomeCategoryState createState() => _IncomeCategoryState();
}

class _IncomeCategoryState extends State<IncomeCategory> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeIncomeItem>(
        create: (context) => ChangeIncomeItem(),
        child: Builder(
            builder: (buildContext) => Scaffold(
                backgroundColor: blue1,
                appBar: CategoryAppBar(EditIncomeCategory(buildContext)),
                body: IncomeCategoryBody(
                    context: buildContext, editIncomeCategory: false))));
  }
}

class IncomeCategoryBody extends StatefulWidget {
  final BuildContext? context, contextEdit;
  final bool editIncomeCategory;
  IncomeCategoryBody(
      {this.context, this.contextEdit, required this.editIncomeCategory});

  @override
  _IncomeCategoryBodyState createState() => _IncomeCategoryBodyState();
}

class _IncomeCategoryBodyState extends State<IncomeCategoryBody> {
  @override
  Widget build(BuildContext context) {
    var incomeList = widget.contextEdit == null
        ? Provider.of<ChangeIncomeItem>(widget.context!).incomeItems
        : Provider.of<ChangeIncomeItemEdit>(widget.contextEdit!).incomeItems;
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: ListView.builder(
        itemCount: incomeList.length,
        itemBuilder: (context, int) {
          return Padding(
            padding: EdgeInsets.only(top: 3.h, left: 10.w, right: 10.w),
            child: GestureDetector(
              onLongPress: () {
                if (this.widget.editIncomeCategory) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCategory(
                              contextIn: widget.context,
                              contextInEdit: widget.contextEdit,
                              type: 'Income',
                              appBarTitle: 'Add Income Category',
                              categoryName: incomeList[int].text,
                              categoryIcon: iconData(incomeList[int]),
                              description: incomeList[int].description!)));
                }
              },
              onTap: () {
                if (this.widget.editIncomeCategory) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCategory(
                              contextIn: widget.context,
                              contextInEdit: widget.contextEdit,
                              type: 'Income',
                              appBarTitle: 'Add Income Category',
                              categoryName: incomeList[int].text,
                              categoryIcon: iconData(incomeList[int]),
                              description: incomeList[int].description!)));
                } else {
                  Navigator.pop(context, incomeList[int]);
                }
              },
              child: Card(
                elevation: 5,
                color: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40.h,
                      ),
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(215, 223, 231, 1),
                        radius: 25.r,
                        child: Icon(
                          iconData(incomeList[int]),
                          size: 33.sp,
                          color: green,
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        getTranslated(context, incomeList[int].text) ??
                            incomeList[int].text,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
