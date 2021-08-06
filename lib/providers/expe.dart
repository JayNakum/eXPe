import 'package:expe/helpers/db_helper.dart';
import 'package:expe/models/expense.dart';
import 'package:flutter/material.dart';

class Expe with ChangeNotifier {
  final List<Expense> _expe = [];

  List<Expense> get expe {
    return [..._expe];
  }

  Future<void> setExpenses() async {
    final dataList = await DBHelper.getData('expenses');
    _expe.clear();
    _expe.addAll(
      dataList
          .map(
            (xp) => Expense(
              xp['id'],
              xp['name'],
              double.parse(xp['amount']),
              DateTime.parse(xp['date']),
            ),
          )
          .toList()
          .reversed,
    );
  }

  void newExpense(Expense expe) {
    _expe.add(expe);
    notifyListeners();
    DBHelper.insert(
      'expenses',
      {
        'id': expe.id.toString(),
        'name': expe.name,
        'amount': expe.amount.toString(),
        'date': expe.date.toString(),
      },
    );
  }

  void removeExpense(String id) {
    _expe.removeWhere(
      (element) => element.id == id,
    );
    notifyListeners();
    DBHelper.delete('expenses', id);
  }

  double total() {
    double _total = 0.0;
    _expe.forEach(
      (expense) {
        _total = _total + expense.amount;
      },
    );
    return _total;
  }
}
