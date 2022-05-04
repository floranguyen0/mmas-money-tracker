import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';
import 'package:money_assistant_2608/project/localization/language.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import '../real_main.dart';

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {

  @override
  Widget build(BuildContext context) {
    List<Language> languageList = Language.languageList;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: blue3,
            title: Text(getTranslated(context, 'Select a language')!,
                style: TextStyle(fontSize: 21.sp)),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: TextButton(
                  child: Text(
                    getTranslated(context, 'Save') ?? 'Save',
                    style: TextStyle(fontSize: 18.5.sp, color: white),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ]
        ),
        body: ChangeNotifierProvider<OnLanguageSelected>(
          create: (context) => OnLanguageSelected(),
          builder: (context, widget) => ListView.builder(
              itemCount: languageList.length,
              itemBuilder: (context, int) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Locale _locale = sharedPrefs.setLocale(languageList[int].languageCode);
                    MyApp.setLocale(context, _locale);
                    context
                        .read<OnLanguageSelected>()
                        .onSelect(languageList[int].languageCode);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 23.w),
                        child: Row(
                          children: [
                            Text(
                              languageList[int].flag,
                              style: TextStyle(fontSize: 45.sp),
                            ),
                            SizedBox(
                              width: 35.w,
                            ),
                            Text(languageList[int].name,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                )),
                            Spacer(),
                            context.watch<OnLanguageSelected>().languageCode ==
                                    languageList[int].languageCode
                                ? Icon(Icons.check_circle,
                                    size: 25.sp, color: blue3)
                                : SizedBox(),
                            SizedBox(width: 15.w)
                          ],
                        ),
                      ),
                      Divider(
                        indent: 90.w,
                        height: 0,
                        thickness: 0.25.h,
                        color: grey,
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
