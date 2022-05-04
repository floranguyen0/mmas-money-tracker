import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/app_bar.dart';
import 'package:money_assistant_2608/project/classes/category_item.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:money_assistant_2608/project/provider.dart';
import 'package:provider/provider.dart';

import 'add_category.dart';
import 'edit_expense_category.dart';

class ExpenseCategory extends StatefulWidget {
  @override
  _ExpenseCategoryState createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeExpenseItem>(
        create: (context) => ChangeExpenseItem(),
        child: Builder(
          builder: (buildContext) => Scaffold(
              backgroundColor: blue1,
              appBar: CategoryAppBar(EditExpenseCategory(buildContext)),
              body: ExpenseCategoryBody(
                contextEx: buildContext,
              )),
        ));
  }
}

class ExpenseCategoryBody extends StatefulWidget {
  final BuildContext? contextExEdit,contextEx;
  ExpenseCategoryBody(
      {this.contextExEdit, this.contextEx});

  @override
  _ExpenseCategoryBodyState createState() => _ExpenseCategoryBodyState();
}

class _ExpenseCategoryBodyState extends State<ExpenseCategoryBody> {
  @override
  Widget build(BuildContext context) {
    var exItemsLists = widget.contextExEdit == null ?
        Provider.of<ChangeExpenseItem>(widget.contextEx!).exItemsLists : Provider.of<ChangeExpenseItemEdit>(widget.contextExEdit!).exItemsLists;
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: exItemsLists.length,
              itemBuilder: (context, int) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: CategoryContainer( contextEx: widget.contextEx , contextExEdit: widget.contextExEdit,
                      itemsList: exItemsLists[int]),
                );
              }),
        ],
      ),
    ));
  }
}

// The named parameter 'body' is required, but there's no corresponding argument.  Try adding the required argument.
// Widget searchBar() {
//   return FloatingSearchAppBar(
//     title: const Text('Enter Category Name'),
//     transitionDuration: const Duration(milliseconds: 800),
//     color: Colors.orangeAccent.shade100,
//     colorOnScroll: Colors.greenAccent.shade200,
//     height: 55,
//   );
// }

class CategoryContainer extends StatefulWidget {
  final BuildContext? contextEx,contextExEdit;
  final List<CategoryItem> itemsList;
  const CategoryContainer(
  { this.contextEx, this.contextExEdit,  required this.itemsList});
  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    if (widget.itemsList.length < 2) {
      return ParentCategory(
        contextEx:  widget.contextEx,
        contextExEdit: widget.contextExEdit,
        noChildren: true,
        parentCategory:  widget.itemsList[0],
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ParentCategory(
          contextEx:  widget.contextEx,
        contextExEdit: widget.contextExEdit,
        noChildren:  false,
          parentCategory:  widget.itemsList[0],
        ),
        CategoryItems(contextEx: widget.contextEx,         contextExEdit: widget.contextExEdit,
            categoryItemChildren:  widget.itemsList.sublist(1),parentItem: widget.itemsList[0]),
      ]),
    );
  }
}

class CategoryItems extends StatefulWidget {
  final BuildContext? contextEx,contextExEdit;
  final List<CategoryItem> categoryItemChildren;
  final CategoryItem parentItem;
  const CategoryItems({this.contextEx, this.contextExEdit,
    required this.categoryItemChildren, required this.parentItem});
  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h, top: 10.h),
      child: Wrap(
        children: List.generate(widget.categoryItemChildren.length, (index) {
          final cellWidth = (1.sw - 20.w) / 4;
          return SizedBox(
            width: cellWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onLongPress:(){
                    if (widget.contextExEdit != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCategory(
                                  contextEx: widget.contextEx,
                                  contextExEdit: widget.contextExEdit,
                                  type: 'Expense',
                                  appBarTitle: 'Add Expense Category',
                                  categoryName:
                                  widget.categoryItemChildren[index].text,
                                  categoryIcon: iconData(
                                      widget.categoryItemChildren[index]),
                                  parentItem: widget.parentItem,
                                  description: widget
                                      .categoryItemChildren[index]
                                      .description!)));
                    }
                  },
                  onTap: () {
                    if (widget.contextExEdit != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCategory(
                                  contextEx: widget.contextEx,
                                  contextExEdit: widget.contextExEdit,
                                  type: 'Expense',
                                  appBarTitle: 'Add Expense Category',
                                  categoryName:
                                  widget.categoryItemChildren[index].text,
                                  categoryIcon: iconData(
                                      widget.categoryItemChildren[index]),
                                  parentItem: widget.parentItem,
                                  description: widget
                                      .categoryItemChildren[index]
                                      .description!)));
                    } else {
                      Navigator.pop(
                          context, widget.categoryItemChildren[index]);
                    }
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 15.h),
                    child: CircleAvatar(
                        radius: 24.r,
                        backgroundColor: Color.fromRGBO(215, 223, 231, 1),
                        child: Icon(
                          iconData(widget.categoryItemChildren[index]),
                          color: red,
                          size: 30.sp,
                        )),
                  ),
                ),
                Text(
                  getTranslated(
                          context, widget.categoryItemChildren[index].text) ??
                      widget.categoryItemChildren[index].text,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ParentCategory extends StatefulWidget {
  final BuildContext? contextEx, contextExEdit;
  final bool noChildren;
  final CategoryItem parentCategory;
  ParentCategory(
  { this.contextEx,
  this.contextExEdit,
    required this.noChildren,
    required this.parentCategory,}
  );
  @override
  _ParentCategoryState createState() => _ParentCategoryState();
}

class _ParentCategoryState extends State<ParentCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress:(){
        if (widget.contextExEdit != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddCategory(
                      contextEx: widget.contextEx,
                      contextExEdit: widget.contextExEdit,
                      type: 'Expense',
                      appBarTitle: 'Add Expense Category',
                      categoryName: widget.parentCategory.text,
                      categoryIcon: iconData(widget.parentCategory),
                      description: widget.parentCategory.description)));
        }
      },
      onTap: () {
        if (widget.contextExEdit != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddCategory(
                    contextEx: widget.contextEx,
                      contextExEdit: widget.contextExEdit,
                      type: 'Expense',
                      appBarTitle: 'Add Expense Category',
                      categoryName: widget.parentCategory.text,
                      categoryIcon: iconData(widget.parentCategory),
                      description: widget.parentCategory.description)));
        }
        // consider category as parent category for simplicity, need to change later
        else {
          Navigator.pop(context, widget.parentCategory);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(222, 174, 112, 1),
          borderRadius: widget.noChildren
              ? BorderRadius.circular(40.r)
              : BorderRadius.vertical(
                  top: Radius.circular(40.r), bottom: Radius.zero),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Color.fromRGBO(215, 223, 231, 1),
                  radius: 26.r,
                  child: Icon(
                    iconData(widget.parentCategory),
                    size: 33.sp,
                    color: red,
                  )),
              SizedBox(
                width: 23.5.w,
              ),
              Expanded(
                child: Text(
                  getTranslated(context, widget.parentCategory.text) ??
                      widget.parentCategory.text,
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
