import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_datepicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptative_textfield.dart';
import 'adaptative_datepicker.dart';

class TransactionFormWidget extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionFormWidget(this.onSubmit);

  @override
  State<TransactionFormWidget> createState() => _TransactionFormWidgetState();
}

class _TransactionFormWidgetState extends State<TransactionFormWidget> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();
  DateTime dateSelected = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(titleController.text,
        double.parse(valueController.text) ?? 0.0, dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                AdaptativeTextField(
                  label: 'Titulo',
                  controller: titleController,
                  onSubmitted: (_) => _submitForm(),
                ),
                AdaptativeTextField(
                  controller: valueController,
                  label: 'Value (R\$)',
                  onSubmitted: (_) => _submitForm(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                AdaptativeDatePicker(
                  selectDate: dateSelected,
                  onDateChanged: (newDateSelected) {
                    setState(() {
                      dateSelected = newDateSelected;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptativeButton("Nova Transation", _submitForm),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
