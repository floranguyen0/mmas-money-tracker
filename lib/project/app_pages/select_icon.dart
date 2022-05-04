import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/classes/app_bar.dart';
import 'package:money_assistant_2608/project/classes/category_item.dart';
import 'package:money_assistant_2608/project/classes/constants.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';


class SelectIcon extends StatelessWidget {
  final String type;
  SelectIcon(this.type);
  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> icons = createItemList(
        forAnalysisPage: false, isIncomeType: false, forSelectIconPage: true);
    return Scaffold(
      appBar: BasicAppBar(getTranslated(context, 'Icons')!),
      body: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 0.82,
        shrinkWrap: true,
        children: List.generate(icons.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, iconData(icons[index])
                        );
                  },
                  iconSize: 60.sp,
                  icon: CircleAvatar(
                      backgroundColor: Color.fromRGBO(215, 223, 231, 1),
                      radius: 24.r,
                      child: Icon(
                        iconData(icons[index]),
                        size: 30.sp,
                        color: this.type == 'Income' ? green : red,
                      )),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
