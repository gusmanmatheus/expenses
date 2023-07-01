import 'dart:math';
import 'dart:io';

import 'package:expenses/components/chartWidget.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(fontFamily: 'QuickSand');
    return MaterialApp(
        home: MyHomePage(),
        theme: theme.copyWith(
            colorScheme: theme.colorScheme
                .copyWith(primary: Colors.purple, secondary: Colors.amber),
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ))));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transaction = [];

  List<Transaction> get _recentTransactions {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionFormWidget(_addTransaction);
        });
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  _addTransaction(String title, double value, DateTime dateTransaction) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: dateTransaction);
    setState(() {
      _transaction.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  Widget _getIconButton(Function() fn, IconData icon) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            //_showChart ? Icons.list : Icons.show_chart)
            icon: Icon(
              icon,
            ),
            onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh: Icons.list;
    final chartList = Platform.isIOS ? CupertinoIcons.refresh: Icons.show_chart;

    final actions = [
      _getIconButton(() => _openTransactionFormModal(context), Platform.isIOS ? CupertinoIcons.add : Icons.add),
      if (isLandscape)
        _getIconButton(() {
          setState(() {
            _showChart = !_showChart;
          });
        }, _showChart ? iconList : chartList)
    ];
    final appBar = AppBar(title: Text('Despesas pessoais'), actions: actions);

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 0.7 : 0.3),
                  child: ChartWidget(_recentTransactions)),
            if (!_showChart || !isLandscape)
              Container(
                  height: availableHeight * 0.70,
                  child: TransactionListWidget(_transaction, _deleteTransaction)),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Despesas Pessoais"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => {_openTransactionFormModal(context)},
            ),
          );
  }
}
