import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/app_bar.dart';
import 'package:money_assistant_2608/project/classes/category_item.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';

class ParentCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<CategoryItem> parentCategories = sharedPrefs.getAllExpenseItemsLists()
        .map((item) => CategoryItem(
            item[0].iconCodePoint,
            item[0].iconFontPackage,
            item[0].iconFontFamily,
            item[0].text,
            item[0].description))
        .toList();
    return Scaffold(
      appBar: BasicAppBar(getTranslated(context, 'Parent category')!),
      body: ListView.builder(
        itemCount: parentCategories.length,
        itemBuilder: (context, int) {
          return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.pop(
                    context,
                    parentCategories[int]);
              },
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Color.fromRGBO(215, 223, 231, 1),
                            radius: 20.r,
                            child: Icon(
                              iconData(parentCategories[int]),
                              size: 25.sp,
                              color: red,
                            )),
                        SizedBox(
                          width: 28.w,
                        ),
                        Expanded(
                          child: Text(
                            getTranslated(context, parentCategories[int].text) ??
                                parentCategories[int].text,
                            style: TextStyle(fontSize: 22.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.25.h,
                    indent: 67.w,
                    color: grey,
                  )
                ],
              ));
        },
      ),
    );
  }
}
