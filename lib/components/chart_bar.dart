import 'package:flutter/material.dart';

class ChartBarWidget extends StatelessWidget {
  final String label;
  final double value;
  final double percentagem;

  ChartBarWidget({
    required this.label,
    required this.value,
    required this.percentagem,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraint){
     return Column(
        children: [
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text('R\$${value.toStringAsFixed(2)}'))),
          SizedBox(height: constraint.maxHeight* 0.05),
          Container(
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromARGB(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                FractionallySizedBox(
                  heightFactor: percentagem,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraint.maxHeight* 0.05),
          Container(height: constraint.maxHeight* 0.15,child: FittedBox (child: Text(label,))),
        ],
      );
    });
  }
}
