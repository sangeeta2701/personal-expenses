import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // ChartBar({Key? key, }) : super(key: key);
  final String lable;
  final double spendingAmount;
  final double spendingPct0fTotal;

  const ChartBar(this.lable, this.spendingAmount, this.spendingPct0fTotal);

  @override
  Widget build(BuildContext context) {
    print('build() ChartBar');
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          // ignore: prefer_const_constructors
          Container(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      // ignore: prefer_const_constructors
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPct0fTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: constraint.maxHeight * 0.05,
          ),
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(lable))),
        ],
      );
    });
  }
}
