import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/database_management/sqflite_services.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'dart:io' show Platform;
import 'app_pages/analysis.dart';
import 'app_pages/input.dart';
import 'localization/methods.dart';
import 'app_pages/calendar.dart';
import 'app_pages/others.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> myBody = [
    AddInput(),
    Analysis(),
    Calendar(),
    Other(),
  ];
  BottomNavigationBarItem bottomNavigationBarItem(
          IconData iconData, String label) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 0.h),
          child: Icon(
            iconData,
          ),
        ),
        label: getTranslated(context, label),
      );

  @override
  void initState() {
    super.initState();
    DB.init();
    var rateMyApp = RateMyApp(
      minDays: 0,
      // Will pop up the first time users launch the app
      minLaunches: 1,
      remindDays: 4,
      remindLaunches: 15,
      googlePlayIdentifier: 'com.mmas.money_assistant_2608',
      appStoreIdentifier: '1582638369',
    );

    WidgetsBinding.instance?.addPostFrameCallback((_) async {

      await rateMyApp.init();
      rateMyApp.conditions.forEach((condition) {
        if (condition is DebuggableCondition) {
          print(condition.valuesAsString);
          // condition.reset();
        }
      });
      if (mounted && rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          // title: 'Rate this app', // The dialog title.
          // message:
          //     'If you like this app, please take a little bit of your time to review it!\nYour support means the world to us ^^', // The dialog message.
          // rateButton: 'RATE', // The dialog "rate" button text.
          // noButton: 'NO THANKS', // The dialog "no" button text.
          // laterButton: 'MAYBE LATER', // The dialog "later" button text.
          // listener: (button) {
          //   // The button click listener (useful if you want to cancel the click event).
          //   switch (button) {
          //     case RateMyAppDialogButton.rate:
          //       print('Clicked on "Rate".');
          //       break;
          //     case RateMyAppDialogButton.later:
          //       print('Clicked on "Later".');
          //       break;
          //     case RateMyAppDialogButton.no:
          //       print('Clicked on "No".');
          //       break;
          //   }
          //   return true; // Return false if you want to cancel the click event.
          // },
          ignoreNativeDialog: Platform
              .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => Text('ok'), // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomItems = <BottomNavigationBarItem>[
      bottomNavigationBarItem(Icons.add, 'Input'),
      bottomNavigationBarItem(Icons.analytics_outlined, 'Analysis'),
      bottomNavigationBarItem(Icons.calendar_today, 'Calendar'),
      bottomNavigationBarItem(Icons.account_circle, 'Other'),
    ];

    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: grey,
              ),
            ],
          ),
          child: BottomNavigationBar(
            iconSize: 27.sp,
            selectedFontSize: 16.sp,
            unselectedFontSize: 14.sp,
            backgroundColor: white,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.black87,
            type: BottomNavigationBarType.fixed,
            items: bottomItems,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: myBody[_selectedIndex]);
  }
}
