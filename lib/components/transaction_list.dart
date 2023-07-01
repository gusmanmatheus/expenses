import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionListWidget(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
          child: transactions.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: constraint.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraint.maxHeight * 0.3,
                      child: Text(
                        'Nenhuma transacao cadastrada',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(
                      height: constraint.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraint.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (ctx, index) {
                    final item = transactions[index];
                    return TransactionItemWidget(
                        key: GlobalObjectKey(item),
                        item: item,
                        onRemove: onRemove);
                  }));
    });
  }
}
