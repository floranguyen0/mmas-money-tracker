import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_assistant_2608/project/localization/methods.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'input_model.dart';

class ChartPie extends StatelessWidget {
  const ChartPie(this.transactionsSorted);
  final List<InputModel> transactionsSorted;
  @override
  Widget build(BuildContext context) {
    bool haveRecords;
    String width;
    String height;
    double animationDuration;

    if (this.transactionsSorted[0].category == '') {
      haveRecords = false;
      width = '67%';
      height = '67%';
      animationDuration = 0;
    } else {
      haveRecords = true;
      width = '67%';
      height = '67%';
      animationDuration = 270;
    }

    return SfCircularChart(
      tooltipBehavior: TooltipBehavior(enable: haveRecords),
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            width: width, height: height, widget: Annotations(haveRecords))
      ],
      series: <CircularSeries<InputModel, String>>[
        DoughnutSeries<InputModel, String>(
            startAngle: 90,
            endAngle: 90,
            animationDuration: animationDuration,
            // enableSmartLabels: haveRecords,
            sortingOrder: SortingOrder.descending,
            sortFieldValueMapper: (InputModel data, _) => data.category,
            enableTooltip: haveRecords,
            dataSource: this.transactionsSorted,
            pointColorMapper: (InputModel data, _) => data.color,
            xValueMapper: (InputModel data, _) => getTranslated(context, data.category!) ?? data.category,
            yValueMapper: (InputModel data, _) => data.amount,
            dataLabelSettings: DataLabelSettings(
              showZeroValue: true,
              useSeriesColor: true,
              labelPosition: ChartDataLabelPosition.outside,
              isVisible: haveRecords,
            ),
            innerRadius: '50%',
            radius: '67%'),
      ],
    );
  }
}

class Annotations extends StatelessWidget {
  final bool haveRecords;
  const Annotations(this.haveRecords);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        child: Container(
          child: haveRecords == false
              ? Center(
                  child: Text(getTranslated(context, 'There is no data')!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 23.5.sp,
                          fontStyle: FontStyle.italic)),
                )
              : null,
        ),
        shape: BoxShape.circle,
        elevation: 10,
        shadowColor: Colors.black,
        color: const Color.fromRGBO(230, 230, 230, 1));
  }
}
