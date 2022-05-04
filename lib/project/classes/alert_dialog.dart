import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';

Future<void> iosDialog(BuildContext context, String content, String action,
        Function onAction) =>
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: EdgeInsets.only(
                bottom: 8.h,
              ),
              child: Text(
                getTranslated(context, 'Please Confirm') ?? 'Please Confirm',
                style: TextStyle(fontSize: 21.sp),
              ),
            ),
            content: Text(getTranslated(context, content) ?? content,
                style: TextStyle(fontSize: 15.5.sp)),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                  child: Text(getTranslated(context, 'Cancel') ?? 'Cancel',
                      style: TextStyle(
                          fontSize: 19.5.sp, fontWeight: FontWeight.w600)),
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  onAction();
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                  child: Text(getTranslated(context, action) ?? action,
                      style: TextStyle(
                          fontSize: 19.5.sp, fontWeight: FontWeight.w600)),
                ),
                isDefaultAction: true,
                isDestructiveAction: true,
              )
            ],
          );
        });

Future<void> androidDialog(BuildContext context, String content, String action,
        Function onAction) =>
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(getTranslated(context, 'Please Confirm')!),
            content: Text(
                getTranslated(context, content) ?? content),
            actions: [
              TextButton(
                  onPressed: () {
                    onAction();
                    Navigator.pop(context);
                  },
                  child: Text(getTranslated(context, 'Cancel') ?? 'Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(getTranslated(context, action) ?? action))
            ],
          );
        });
