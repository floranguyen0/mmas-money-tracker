import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/localization/language.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class Currency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Language> languageList = Language.languageList;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: blue3,
          title: Text(
              getTranslated(context, 'Select a currency') ??
                  'Select a currency',
              style: TextStyle(fontSize: 21.sp)),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: TextButton(
                  child: Text(
                    getTranslated(context, 'Save') ?? 'Save',
                    style: TextStyle(fontSize: 18.5.sp, color: white),
                  ),
                  onPressed: () => Navigator.pop(context)),
            )
          ]),
      body: ChangeNotifierProvider<OnCurrencySelected>(
          create: (context) => OnCurrencySelected(),
          builder: (context, widget) => ListView.builder(
              itemCount: languageList.length,
              itemBuilder: (context, int) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.read<OnCurrencySelected>().onCurrencySelected(
                        '${languageList[int].languageCode}_${languageList[int].countryCode}');
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Text(
                              Language.languageList[int].flag,
                              style: TextStyle(fontSize: 45.sp),
                            ),
                            SizedBox(width: 30.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Language.languageList[int].currencyName,
                                    style: TextStyle(fontSize: 20.sp)),
                                SizedBox(height: 2.5.h),
                                Text(Language.languageList[int].currencyCode,
                                    style: TextStyle(fontSize: 15.sp))
                              ],
                            ),
                            Spacer(),
                            context.watch<OnCurrencySelected>().appCurrency ==
                                    '${languageList[int].languageCode}_${languageList[int].countryCode}'
                                ? Icon(Icons.check_circle,
                                    size: 25.sp, color: blue3)
                                : SizedBox(),
                            SizedBox(width: 25.w),
                            Text(
                              Language.languageList[int].currencySymbol,
                              style: TextStyle(fontSize: 23.sp),
                            ),
                            SizedBox(width: 15.w)
                          ],
                        ),
                      ),
                      Divider(
                        indent: 75.w,
                        height: 0,
                        thickness: 0.25.h,
                        color: grey,
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
