import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectDate;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker({required this.selectDate, required this.onDateChanged});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selected) {
      if (selected == null) {
        return;
      }
      onDateChanged(selectDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2019),
              maximumDate: DateTime.now(),
              minimumDate: DateTime(2019),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Container(
            height: 70,
            child: Row(children: [
              Expanded(child: Text('Data Selecionada ${DateFormat('''
                          d/MM/y''').format(selectDate)}')),
              TextButton(
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  child: Text(
                    'Selecionar data',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )),
            ]),
          );
  }
}
