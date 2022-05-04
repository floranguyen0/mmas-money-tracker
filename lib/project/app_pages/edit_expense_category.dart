import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_assistant_2608/project/classes/app_bar.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'add_category.dart';
import 'expense_category.dart';

class EditExpenseCategory extends StatefulWidget {
  final BuildContext buildContext;
  EditExpenseCategory(this.buildContext);
  @override
  _EditExpenseCategoryState createState() => _EditExpenseCategoryState();
}

class _EditExpenseCategoryState extends State<EditExpenseCategory> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeExpenseItemEdit>(
        create: (context) => ChangeExpenseItemEdit(),
        child: Builder(
            builder: (contextEdit) => Scaffold(
                backgroundColor: blue1,
                appBar: EditCategoryAppBar(
                  AddCategory(
                      contextEx: widget.buildContext,
                      contextExEdit: contextEdit,
                      type: 'Expense',
                      appBarTitle:
                          getTranslated(context, 'Add Expense Category')!,
                      description: ''),
                ),
                body: ExpenseCategoryBody(
                  contextExEdit: contextEdit,
                  contextEx: widget.buildContext,
                ))));
  }
}
