import 'dart:ui';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:money_assistant_2608/project/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';



class DropDownBox extends StatelessWidget {
  final bool forAnalysis;
  final String selectedDate;
  const DropDownBox(this.forAnalysis, this.selectedDate);
  @override
  Widget build(BuildContext context) {
    return  DecoratedBox(
      decoration: ShapeDecoration(
        shadows: [BoxShadow()],
        color: blue2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
      ),
      child: SizedBox(
        height:  35.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              dropdownColor: blue2,
              value: selectedDate,
              elevation: 10,
              icon: Icon(
                Icons.arrow_drop_down_outlined,
                size: 28.sp,
              ),
              onChanged: (value) {
                if (this.forAnalysis) {
                  context
                      .read<ChangeSelectedDate>()
                      .changeSelectedAnalysisDate(
                      newSelectedDate: value.toString());
                  sharedPrefs.selectedDate = value.toString();
                } else {
                  context
                      .read<ChangeSelectedDate>()
                      .changeSelectedReportDate(
                      newSelectedDate: value.toString());
                }
              },
              items: timeline
                  .map((time) => DropdownMenuItem(
                value: time,
                child: Text(
                  getTranslated(context, time)!,
                  style: TextStyle(
                      fontSize: 18.5.sp),
                  textAlign: TextAlign.center,
                ),
              ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}


