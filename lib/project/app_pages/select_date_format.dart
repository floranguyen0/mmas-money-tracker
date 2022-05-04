import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class FormatDate extends StatelessWidget {
  const FormatDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> dateFormats = [
      'dd/MM/yyyy',
      'MM/dd/yyyy',
      'yyyy/MM/dd',
      'yMMMd',
      'MMMEd',
      'MEd',
      'MMMMd',
      'MMMd',
    ];
    return Scaffold(
        appBar: AppBar(
            backgroundColor: blue3,
            title: Text(
                getTranslated(context, 'Select a date format') ??
                    'Select a date format',
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
        body: ChangeNotifierProvider<OnDateFormatSelected>(
          create: (context) => OnDateFormatSelected(),
          builder: (context, widget) => ListView.builder(
              itemCount: dateFormats.length,
              itemBuilder: (context, int) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      context
                          .read<OnDateFormatSelected>()
                          .onDateFormatSelected(dateFormats[int]);
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                                27.h),
                            child: Row(
                              children: [
                                Text(
                                  '${DateFormat(dateFormats[int]).format(now)}',
                                  style: TextStyle(
                                      fontSize: 19.sp,
                                  ),
                                ),
                                Spacer(),
                                context
                                            .watch<OnDateFormatSelected>()
                                            .dateFormat ==
                                        dateFormats[int]
                                    ? Icon(Icons.check_circle,
                                        size: 25.sp, color: blue3)
                                    : SizedBox()
                              ],
                            ),
                          ),
                          Divider(height: 0, thickness: 0.25, color: grey)
                        ]),
                  )),
        ));
  }
}
