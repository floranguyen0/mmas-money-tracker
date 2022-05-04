import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/app_pages/input.dart';

import 'constants.dart';


class BasicAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const BasicAppBar(this.title);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blue3,
      title: Text(title, style: TextStyle(fontSize: 21.sp)),
    );
  }
}


class InExAppBar extends StatelessWidget implements PreferredSizeWidget {
final bool isInputPage;
const InExAppBar(this.isInputPage);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Tab appBarTab(String title) => Tab(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(),
        child: Align(
            child: Text(
              getTranslated(context, title)!,
              style: TextStyle(fontSize: 19.sp),
            )),
      ),
    );
    return AppBar(
      backgroundColor: blue2,
      title: TabBar(
        unselectedLabelColor: white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: Color.fromRGBO(82, 179, 252, 1),
        ),
        tabs: [
         appBarTab('EXPENSE'),
          appBarTab('INCOME')
        ],
      ),
      actions: isInputPage ? [
        IconButton(
          icon: Icon(Icons.check),
          iconSize: 28,
          onPressed: () {
            saveInputFunc(context,true);
          },
        )
      ] : null,
    );
  }
}


class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget editCategory;
  const CategoryAppBar(this.editCategory);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blue3,
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: 20.w,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editCategory));
            },
            child: Row(children: [
              Icon(
                Icons.edit,
                size: 19.sp,
              ),
              SizedBox(width: 3.w),
              Text(
                getTranslated(context, 'Edit')!,
                style: TextStyle(fontSize: 19.sp),
              ),
            ]),
          ),
          // child: Icon(Icons.edit),
        ),
      ],
      title: Text(getTranslated(context, 'Category')!,
          style: TextStyle(fontSize: 21.sp)),
    );
  }
}


class EditCategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget addCategory;
  const EditCategoryAppBar(this.addCategory);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blue3,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: TextButton(
            onPressed: () =>  Navigator.push(context,
                MaterialPageRoute(builder: (context) => addCategory)),
            child: Text(
              getTranslated(context, 'Add')!,
              style: TextStyle(fontSize: 18.5.sp,  color: white),
            ),
          ),
          // child: Icon(Icons.edit),
        ),
      ],
      title: Text(getTranslated(context, 'Edit Category')!,
          style: TextStyle(fontSize: 21.sp)),
    );
  }
}


