// import 'dart:collection';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:money_assistant_2608/project/classes/app_bar.dart';
// import 'package:money_assistant_2608/project/classes/category_item.dart';
// import 'package:money_assistant_2608/project/classes/constants.dart';
// import 'package:money_assistant_2608/project/classes/input_model.dart';
// import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';
// import 'package:money_assistant_2608/project/database_management/sqflite_services.dart';
// import 'package:money_assistant_2608/project/localization/methods.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../classes/input_model.dart';
// import 'edit.dart';
//
// class Calendar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: blue1,
//         appBar: BasicAppBar(getTranslated(context, 'Calendar')!),
//         body: CalendarBody());
//   }
// }
//
// class CalendarBody extends StatefulWidget {
//   @override
//   _CalendarBodyState createState() => _CalendarBodyState();
// }
//
// class _CalendarBodyState extends State<CalendarBody> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
//       .toggledOff; // Can be toggled on/off by longpressing a date
//   DateTime _focusedDay = DateTime.now(),
//       today = DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   DateTime? _selectedDay, _rangeStart, _rangeEnd;
//   late Map<DateTime, List<InputModel>> transactions = {};
//   late ValueNotifier<List<InputModel>> _selectedEvents;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//   }
//
//   @override
//   void dispose() {
//     // _calendarController.dispose();
//     super.dispose();
//   }
//
//   int getHashCode(DateTime key) {
//     return key.day * 1000000 + key.month * 10000 + key.year;
//   }
//
//   /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
//   List<DateTime> daysInRange(DateTime first, DateTime last) {
//     final dayCount = last.difference(first).inDays + 1;
//     return List.generate(
//       dayCount,
//           (index) => DateTime.utc(first.year, first.month, first.day + index),
//     );
//   }
//
//   Widget buildEvents(List<InputModel>? transactions) {
//     Color colorCategory;
//     if (transactions == null) {
//       return Container();
//     }
//     List<CategoryItem> itemList = createItemList(
//       transactions: transactions,
//       forAnalysisPage: false,
//       forSelectIconPage: false,
//       isIncomeType: false,
//     );
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: itemList.length,
//         itemBuilder: (context, int) {
//           colorCategory =
//           transactions[int].type == 'Income' ? Colors.lightGreen : red;
//           return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Edit(
//                           inputModel: transactions[int],
//                           categoryIcon: iconData(itemList[int]),
//                         ))).then((value) => setState(() {}));
//               },
//               child: Column(
//                 children: [
//                   Container(
//                     color: white,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 15.w, vertical: 15.h),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(
//                             iconData(itemList[int]),
//                             color: colorCategory,
//                           ),
//                           SizedBox(
//                             width: 150.w,
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 15.w, right: 10.w),
//                               child: Text(
//                                   getTranslated(context, itemList[int].text) ??
//                                       itemList[int].text,
//                                   style: TextStyle(
//                                     fontSize: 18.sp,
//                                   ),
//                                   overflow: TextOverflow.ellipsis),
//                             ),
//                           ),
//                           Expanded(
//                             child: Text('(${transactions[int].description})',
//                                 style: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontStyle: FontStyle.italic),
//                                 overflow: TextOverflow.fade),
//                           ),
//                           //this widget will never overflow
//                           Flexible(
//                             flex: 0,
//                             child: Padding(
//                               padding: EdgeInsets.only(right: 10.w, left: 7.w),
//                               child: Text(
//                                   format(transactions[int].amount!) +
//                                       ' ' +
//                                       currency,
//                                   style: GoogleFonts.aBeeZee(
//                                     fontSize: format(transactions[int].amount!)
//                                         .length >
//                                         15
//                                         ? 16.sp
//                                         : 17.sp,
//                                   ),
//                                   overflow: TextOverflow.ellipsis),
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 15.5.sp,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 0,
//                     thickness: 0.25.h,
//                     indent: 20.w,
//                     color: grey,
//                     // color: Color.fromRGBO(213, 215, 217, 1),
//                   ),
//                 ],
//               ));
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<InputModel>>(
//         initialData: [],
//         future: DB.inputModelList(),
//         builder: (context, snapshot) {
//           connectionUI(snapshot);
//           Map<String, List<InputModel>> map = {};
//           if (snapshot.data != null) {
//             for (int i = 0; i < snapshot.data!.length; i++) {
//               String description = snapshot.data![i].description!;
//               InputModel map1 = InputModel(
//                   id: snapshot.data![i].id,
//                   type: snapshot.data![i].type,
//                   amount: snapshot.data![i].amount,
//                   category: snapshot.data![i].category,
//                   description: description,
//                   date: snapshot.data![i].date,
//                   time: snapshot.data![i].time);
//
//               void updateMapValue<K, V>(Map<K, List<V>> map, K key, V value) =>
//                   map.update(key, (list) => list..add(value),
//                       ifAbsent: () => [value]);
//
//               updateMapValue(
//                 map,
//                 '${snapshot.data![i].date}',
//                 map1,
//               );
//             }
//             transactions = map.map((key, value) =>
//                 MapEntry(DateFormat('dd/MM/yyyy').parse(key), value));
//           }
//
//           late LinkedHashMap linkedHashedMapTransactions =
//           LinkedHashMap<DateTime, List<InputModel>>(
//             equals: isSameDay,
//             hashCode: getHashCode,
//           )..addAll(transactions);
//
//           List<InputModel> transactionsForDay(DateTime? day) =>
//               linkedHashedMapTransactions[day] ?? [];
//
//           if (_selectedDay != null) {
//             _selectedEvents = ValueNotifier(transactionsForDay(_selectedDay));
//           }
//
//           List<InputModel> _getEventsForRange(DateTime start, DateTime end) {
//             final days = daysInRange(start, end);
//
//             return [
//               for (final d in days) ...transactionsForDay(d),
//             ];
//           }
//
//           void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//             if (!isSameDay(_selectedDay, selectedDay)) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay;
//                 _rangeStart = null; // Important to clean those
//                 _rangeEnd = null;
//                 _rangeSelectionMode = RangeSelectionMode.toggledOff;
//               });
//               _selectedEvents.value = transactionsForDay(selectedDay);
//             }
//           }
//
//           void _onRangeSelected(
//               DateTime? start, DateTime? end, DateTime focusedDay) {
//             setState(() {
//               _selectedDay = null;
//               _focusedDay = focusedDay;
//               _rangeStart = start;
//               _rangeEnd = end;
//               _rangeSelectionMode = RangeSelectionMode.toggledOn;
//               if (start != null && end != null) {
//                 _selectedEvents = ValueNotifier(_getEventsForRange(start, end));
//               } else if (start != null) {
//                 _selectedEvents = ValueNotifier(transactionsForDay(start));
//               } else if (end != null) {
//                 _selectedEvents = ValueNotifier(transactionsForDay(end));
//               }
//             });
//           }
//
//           return Column(children: [
//             TableCalendar<InputModel>(
//               availableCalendarFormats: {
//                 CalendarFormat.month: getTranslated(context, 'Month')!,
//                 CalendarFormat.twoWeeks: getTranslated(context, '2 weeks')!,
//                 CalendarFormat.week: getTranslated(context, 'Week')!
//               },
//               locale: Localizations.localeOf(context).languageCode,
//               // sixWeekMonthsEnforced: true,
//               // shouldFillViewport: true,
//               rowHeight: 52.h,
//               daysOfWeekHeight: 22.h,
//               firstDay: DateTime.utc(2000, 01, 01),
//               lastDay: DateTime.utc(2050, 01, 01),
//               focusedDay: _focusedDay,
//               calendarFormat: _calendarFormat,
//               selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//               rangeStartDay: _rangeStart,
//               rangeEndDay: _rangeEnd,
//               rangeSelectionMode: _rangeSelectionMode,
//               eventLoader: transactionsForDay,
//               startingDayOfWeek: StartingDayOfWeek.monday,
//               calendarStyle: CalendarStyle(
//                 // weekendTextStyle:
//                 // TextStyle().copyWith(color: Colors.blue[800]),
//               ),
//
//               headerStyle: HeaderStyle(
//                 formatButtonTextStyle: TextStyle(fontSize: 18.sp),
//                 formatButtonDecoration: BoxDecoration(
//                     boxShadow: [BoxShadow()],
//                     color: blue2,
//                     borderRadius: BorderRadius.circular(25.r)),
//               ),
//               calendarBuilders: CalendarBuilders(
//                 selectedBuilder: (context, date, _) {
//                   return Container(
//                     //see difference between margin and padding below: Margin: Out (for itself), padding: In (for its child)
//                     // margin: EdgeInsets.all(4.0.w),
//                     padding: EdgeInsets.only(top: 6.0.h, left: 6.0.w),
//                     color: Color.fromRGBO(255, 168, 68, 1),
//                     width: 46.w,
//                     height: 46.h,
//                     child: Text(
//                       '${date.day}',
//                       style: TextStyle().copyWith(fontSize: 17.0.sp),
//                     ),
//                   );
//                 },
//                 todayBuilder: (context, date, _) {
//                   return Container(
//                     padding: EdgeInsets.only(top: 6.0.w, left: 6.0.w),
//                     color: blue2,
//                     width: 46.w,
//                     height: 46.h,
//                     child: Text(
//                       '${date.day}',
//                       style: TextStyle().copyWith(fontSize: 17.0.sp),
//                     ),
//                   );
//                 },
//                 markerBuilder: (context, date, events) {
//                   if (events.isNotEmpty) {
//                     return Positioned(
//                       right: 1.w,
//                       bottom: 1.h,
//                       child: _buildEventsMarker(date, events),
//                     );
//                   }
//                 },
//               ),
//
//               onDaySelected: _onDaySelected,
//               onRangeSelected: _onRangeSelected,
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 _focusedDay = focusedDay;
//               },
//               pageJumpingEnabled: true,
//             ),
//             SizedBox(height: 8.0.h),
//             Expanded(
//               child: ValueListenableBuilder<List<InputModel>>(
//                 valueListenable: _selectedEvents,
//                 builder: (context, value, _) {
//                   return Column(children: [
//                     Balance(value),
//                     Expanded(child: buildEvents(value))
//                   ]);
//                 },
//               ),
//             )
//           ]);
//         });
//   }
// }
//
// Widget _buildEventsMarker(DateTime date, List events) {
//   double width = events.length < 100 ? 18.w : 28.w;
//   return AnimatedContainer(
//     duration: const Duration(milliseconds: 300),
//     decoration: BoxDecoration(
//       shape: BoxShape.rectangle,
//       color: Color.fromRGBO(67, 125, 229, 1),
//     ),
//     width: width,
//     height: 18.0.h,
//     child: Center(
//       child: Text(
//         '${events.length}',
//         style: TextStyle().copyWith(
//           color: white,
//           fontSize: 13.0.sp,
//         ),
//       ),
//     ),
//   );
// }
//
// class Balance extends StatefulWidget {
//   final List? events;
//   Balance(this.events);
//   @override
//   _BalanceState createState() => _BalanceState();
// }
//
// class _BalanceState extends State<Balance> {
//   @override
//   Widget build(BuildContext context) {
//     double income = 0, expense = 0, balance = 0;
//     if (widget.events != null) {
//       for (int i = 0; i < widget.events!.length; i++) {
//         if (widget.events![i].type == 'Income') {
//           income = income + widget.events![i].amount;
//         } else {
//           expense = expense + widget.events![i].amount;
//         }
//         balance = income - expense;
//       }
//     }
//     Widget summaryFrame(String type, double amount, color) => Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // this widget will never overflow
//         Text(
//           getTranslated(context, type)!,
//           style: TextStyle(
//               color: color,
//               fontSize: 15.sp,
//               fontStyle: FontStyle.italic,
//               fontWeight: FontWeight.bold),
//         ),
//         Text(format(amount.toDouble()) + ' ' + currency,
//             style: GoogleFonts.aBeeZee(
//                 color: color,
//                 fontSize: (format(amount.toDouble()).length > 19)
//                     ? 11.5.sp
//                     : format(amount.toDouble()).length > 14
//                     ? 14.sp
//                     : 18.sp,
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.bold),
//             overflow: TextOverflow.ellipsis)
//       ],
//     );
//     return Container(
//       color: Colors.white54,
//       height: 69.h,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             summaryFrame(
//               'INCOME',
//               income,
//               Colors.lightGreen,
//             ),
//             Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5.w),
//                 child: summaryFrame('EXPENSE', expense, red)),
//             Flexible(
//                 child: summaryFrame('TOTAL BALANCE', balance, Colors.black)),
//           ],
//         ),
//       ),
//     );
//   }
// }
