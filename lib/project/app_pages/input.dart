import 'dart:core';
import 'dart:io' show Platform;
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:money_assistant_2608/project/classes/alert_dialog.dart';
import 'package:money_assistant_2608/project/classes/app_bar.dart';
import 'package:money_assistant_2608/project/classes/category_item.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/classes/custom_toast.dart';
import 'package:money_assistant_2608/project/classes/input_model.dart';
import 'package:money_assistant_2608/project/classes/keyboard.dart';
import 'package:money_assistant_2608/project/classes/saveOrSaveAndDeleteButtons.dart';
import 'package:money_assistant_2608/project/database_management/shared_preferences_services.dart';
import 'package:money_assistant_2608/project/database_management/sqflite_services.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../provider.dart';
import 'expense_category.dart';
import 'income_category.dart';

late CategoryItem defaultCategory;
var selectedTime = TimeOfDay.now();
var selectedDate = DateTime.now();
InputModel model = InputModel();
PanelController _pc = PanelController();
late TextEditingController _amountController;
FocusNode? amountFocusNode, descriptionFocusNode;

class AddInput extends StatefulWidget {
  @override
  _AddInputState createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {
  static final _formKey1 = GlobalKey<FormState>(debugLabel: '_formKey1'),
      _formKey2 = GlobalKey<FormState>(debugLabel: '_formKey2');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasFocus || !currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          if (_pc.isPanelOpen) {
            _pc.close();
          }
        }
      },
      child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
              backgroundColor: blue1,
              appBar: InExAppBar(true),
              body:
                  // ChangeNotifierProvider<ChangeModelType>(
                  //     create: (context) => ChangeModelType(),
                  //     child:
                  PanelForKeyboard(
                TabBarView(
                  children: [
                    AddEditInput(
                      type: 'Expense',
                      formKey: _formKey2,
                    ),
                    AddEditInput(
                      type: 'Income',
                      formKey: _formKey1,
                    )
                  ],
                ),
              ))),
    )
        // )
        ;
  }
}

class PanelForKeyboard extends StatelessWidget {
  const PanelForKeyboard(
    this.body,
  );
  final Widget body;
  void _insertText(String myText) {
    final text = _amountController.text;
    TextSelection textSelection = _amountController.selection;
    String newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    if (newText.length > 13) {
      newText = newText.substring(0, 13);
    }
    // if input starts to have '.' => Don't need to reformat
    if (newText.contains('.')) {
      String fractionalNumber = newText.split('.').last;
      // input can not have more than 2 numbers after a decimal point
      if (fractionalNumber.length > 2) {
        String wholeNumber = newText.split('.').first;
        newText = wholeNumber + '.' + fractionalNumber.substring(0, 2);
      }

      if (newText.substring(newText.length - 1) == '.') {
        // input can not have more than 1 dot
        if ('.'.allMatches(newText).length == 2) {
          newText = newText.substring(0, newText.length - 1);
        }
      }
      _amountController.text = newText;
    } else {
      _amountController.text =
          format(double.parse(newText.replaceAll(',', '')));
    }

    //define text input and cursor position
    textSelection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length));
    _amountController.selection = textSelection;
  }

  void _backspace() {
    final text = _amountController.text;
    TextSelection textSelection = _amountController.selection;

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      // if users delete all input or if input has '.'
      // => Don't need to reformat when deleting
      if (newText == '' || newText.contains('.')) {
        _amountController.text = newText;
      } else {
        _amountController.text =
            format(double.parse(newText.replaceAll(',', '')));
      }

      textSelection = TextSelection.fromPosition(
          TextPosition(offset: _amountController.text.length));
      _amountController.selection = textSelection;
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    if (newText == '' || newText.contains('.')) {
      _amountController.text = newText;
    } else {
      _amountController.text =
          format(double.parse(newText.replaceAll(',', '')));
    }
    textSelection = TextSelection.fromPosition(
        TextPosition(offset: _amountController.text.length));
    _amountController.selection = textSelection;
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        controller: _pc,
        minHeight: 0,
        maxHeight: 300.h,
        parallaxEnabled: true,
        isDraggable: false,
        panelSnapping: true,
        panel: CustomKeyboard(
          panelController: _pc,
          mainFocus: amountFocusNode,
          nextFocus: descriptionFocusNode,
          onTextInput: (myText) {
            _insertText(myText);
          },
          onBackspace: () {
            _backspace();
          },
          page: model.type == 'Income'
              // Provider.of<ChangeModelType>(context).modelType == 'Income'
              ? IncomeCategory()
              : ExpenseCategory(),
        ),
        body: this.body);
  }
}

class AddEditInput extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final InputModel? inputModel;
  final String? type;
  final IconData? categoryIcon;
  const AddEditInput({
    required this.formKey,
    this.inputModel,
    this.type,
    this.categoryIcon,
  });
  @override
  Widget build(BuildContext context) {
    if (this.inputModel != null) {
      model = this.inputModel!;
      defaultCategory = categoryItem(this.categoryIcon!, model.category!);
      // Provider.of<ChangeModelType>(context, listen: false)
      //     .changeModelType(this.inputModel!.type!);
    } else {
      model = InputModel(
        type: this.type,
      );
      defaultCategory = categoryItem(Icons.category_outlined, 'Category');
      // Provider.of<ChangeModelType>(context, listen: false)
      //     .changeModelType(this.type!);
    }
    return ChangeNotifierProvider<ChangeCategoryA>(
        create: (context) => ChangeCategoryA(),
        child: ListView(children: [
          AmountCard(),
          SizedBox(
            height: 30.h,
          ),
          Container(
            decoration: BoxDecoration(
                color: white,
                border: Border.all(
                  color: grey,
                  width: 0.6.w,
                )),
            child: Column(
              children: [
                CategoryCard(),
                DescriptionCard(),
                DateCard(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 70.h),
            child: this.inputModel != null
                ? SaveAndDeleteButton(
                    saveAndDeleteInput: true,
                    formKey: this.formKey,
                  )
                : SaveButton(true, null, true),
          )
        ]));
  }
}

class AmountCard extends StatefulWidget {
  @override
  _AmountCardState createState() => _AmountCardState();
}

class _AmountCardState extends State<AmountCard> {
  @override
  void initState() {
    super.initState();
    amountFocusNode = FocusNode();
    _amountController = TextEditingController(
      text: model.id == null ? '' : format(model.amount!),
    );
  }
  // @override
  // void dispose(){
  //   amountFocusNode!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Color colorMain = model.type == 'Income' ? green : red;
    return Container(
      decoration: BoxDecoration(
          color: white,
          border: Border(
              bottom: BorderSide(
            color: grey,
            width: 0.6.h,
          ))),
      child: Padding(
        padding:
            EdgeInsets.only(top: 15.h, bottom: 30.h, right: 20.w, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${getTranslated(context, 'Amount')}',
              style: TextStyle(
                fontSize: 22.sp,
              ),
            ),
            TextFormField(
              controller: _amountController,
              readOnly: true,
              showCursor: true,
              maxLines: null,
              minLines: 1,
              // maxLength: ,
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'^\d*(.?|,?)\d{0,2}')),
              // ],
              onTap: () => _pc.open(),
              cursorColor: colorMain,
              style: GoogleFonts.aBeeZee(
                  color: colorMain,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold),
              focusNode: amountFocusNode,
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: GoogleFonts.aBeeZee(
                    color: colorMain,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold),
                icon: Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Icon(
                    Icons.monetization_on,
                    size: 45.sp,
                    color: colorMain,
                  ),
                ),
                suffixIcon: _amountController.text.length > 0
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          _amountController.clear();
                        })
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeCategoryA>(builder: (_, changeCategoryA, __) {
      changeCategoryA.categoryItemA ??= defaultCategory;
      var categoryItem = changeCategoryA.categoryItemA;
      model.category = categoryItem!.text;
      return GestureDetector(
          onTap: () async {
            if (_pc.isPanelOpen) {
              _pc.close();
            }
            CategoryItem newCategoryItem = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => model.type == 'Income'
                      ? IncomeCategory()
                      : ExpenseCategory()),
            );
            changeCategoryA.changeCategory(newCategoryItem);
          },
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 20.h, bottom: 21.h),
              child: Row(
                children: [
                  Icon(
                    iconData(categoryItem),
                    size: 40.sp,
                    color: model.type == 'Income' ? green : red,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 31.w),
                      child: Text(
                        getTranslated(context, categoryItem.text) ??
                            categoryItem.text,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
            Divider(
              height: 0,
              thickness: 0.25.w,
              color: grey,
              indent: 85.w,
            ),
          ]));
    });
  }
}

class DescriptionCard extends StatefulWidget {
  @override
  _DescriptionCardState createState() => _DescriptionCardState();
}

class _DescriptionCardState extends State<DescriptionCard> {
  static late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    descriptionFocusNode = FocusNode();
    descriptionController =
        TextEditingController(text: model.description ?? '');
  }

  // @override
  // void dispose(){
  //   descriptionFocusNode!.dispose();
  //   super.dispose();
  // }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        nextFocus: false,
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        actions: [
          KeyboardActionsItem(
              focusNode: descriptionFocusNode!,
              toolbarButtons: [
                (node) {
                  return SizedBox(
                    width: 1.sw,
                    child: Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(amountFocusNode);
                                _pc.open();
                              },
                              child: SizedBox(
                                height: 35.h,
                                width: 60.w,
                                child: Icon(Icons.keyboard_arrow_up,
                                    size: 25.sp, color: Colors.blueGrey),
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     node.unfocus();
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => model.type == 'Income'
                            //                 ? IncomeCategory()
                            //                 : ExpenseCategory()));
                            //   },
                            //   child: Text(
                            //     getTranslated(context, 'Choose Category')!,
                            //     style: TextStyle(
                            //         fontSize: 16.sp,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.blueGrey),
                            //   ),
                            // ),
                            GestureDetector(
                                onTap: () => node.unfocus(),
                                child: Text(
                                  getTranslated(context, "Done")!,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ))
                          ],
                        )),
                  );
                },
              ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      overscroll: 0,
      disableScroll: true,
      tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
      autoScroll: false,
      config: _buildConfig(context),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.5.h),
          child: TextFormField(
            controller: descriptionController,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            keyboardAppearance: Brightness.light,
            // maxLength: ,
            onTap: () {
              if (_pc.isPanelOpen) {
                _pc.close();
              }
            },
            cursorColor: blue1,
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(fontSize: 20.sp),
            focusNode: descriptionFocusNode,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslated(context, 'Description'),
                hintStyle: GoogleFonts.cousine(
                  fontSize: 22.sp,
                  fontStyle: FontStyle.italic,
                ),
                suffixIcon: descriptionController.text.length > 0
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          descriptionController.clear();
                        })
                    : SizedBox(),
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Icon(
                    Icons.description_outlined,
                    size: 40.sp,
                    color: Colors.blueGrey,
                  ),
                )),
          ),
        ),
        Divider(
          height: 0,
          thickness: 0.25.w,
          color: grey,
          indent: 85.w,
        )
      ]),
    );
  }
}

class DateCard extends StatefulWidget {
  const DateCard();
  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  @override
  Widget build(BuildContext context) {
    if (model.date == null) {
      model.date = DateFormat('dd/MM/yyyy').format(selectedDate);
      model.time = selectedTime.format(context);
    }
    return Padding(
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 17.5.h, bottom: 19.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (_pc.isPanelOpen) {
                _pc.close();
              }
              showMaterialDatePicker(
                headerColor: blue3,
                headerTextColor: Colors.black,
                backgroundColor: white,
                buttonTextColor: Color.fromRGBO(80, 157, 253, 1),
                cancelText: getTranslated(context, 'CANCEL'),
                confirmText: getTranslated(context, 'OK') ?? 'OK',
                maxLongSide: 450.w,
                maxShortSide: 300.w,
                title: getTranslated(context, 'Select a date'),
                context: context,
                firstDate: DateTime(1990, 1, 1),
                lastDate: DateTime(2050, 12, 31),
                selectedDate: DateFormat('dd/MM/yyyy').parse(model.date!),
                onChanged: (value) => setState(() {
                  selectedDate = value;
                  model.date = DateFormat('dd/MM/yyyy').format(value);
                }),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: Icon(
                    Icons.event,
                    size: 40.sp,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  DateFormat(sharedPrefs.dateFormat).format(
                      DateFormat('dd/MM/yyyy').parse(
                          model.date!)),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 21.5.sp,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (_pc.isPanelOpen) {
                _pc.close();
              }
              Navigator.of(context).push(
                showPicker(
                    cancelText: getTranslated(context, 'Cancel') ?? 'Cancel',
                    okText: getTranslated(context, 'Ok') ?? 'Ok',
                    unselectedColor: grey,
                    dialogInsetPadding: EdgeInsets.symmetric(
                        horizontal: 50.w, vertical: 30.0.h),
                    elevation: 12,
                    context: context,
                    value: selectedTime,
                    is24HrFormat: true,
                    onChange: (value) => setState(() {
                          selectedTime = value;
                          model.time = value.format(context);
                        })),
              );
            },
            child: Text(
              model.time!,
              style: GoogleFonts.aBeeZee(
                fontSize: 21.5.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}

void saveInputFunc(BuildContext context, bool saveFunction) {
  model.amount = _amountController.text.isEmpty
      ? 0
      : double.parse(_amountController.text.replaceAll(',', ''));
  model.description = _DescriptionCardState.descriptionController.text;
  if (saveFunction) {
    DB.insert(model);
    _amountController.clear();
    if (_DescriptionCardState.descriptionController.text.length > 0) {
      _DescriptionCardState.descriptionController.clear();
    }
    customToast(context, 'Data has been saved');
  } else {
    DB.update(model);
    Navigator.pop(context);
    customToast(context, getTranslated(context, 'Transaction has been updated') ?? 'Transaction has been updated');
  }
}

Future<void> deleteInputFunction(
  BuildContext context,
) async {
  void onDeletion() {
    DB.delete(model.id!);
    Navigator.pop(context);
    customToast(context, 'Transaction has been deleted');
  }

  Platform.isIOS
      ? await iosDialog(
          context,
          'Are you sure you want to delete this transaction?',
          'Delete',
          onDeletion)
      : await androidDialog(
          context,
          'Are you sure you want to delete this transaction?',
          'Delete',
          onDeletion);
}
