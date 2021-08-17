import 'package:expe/helpers/db_helper_sqlite.dart';
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
          .toList(),
      // .reversed,
    );
    _expe.sort((a, b) => b.date.compareTo(a.date));
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

  void deleteAll() {
    _expe.clear();
    notifyListeners();
    DBHelper.drop();
  }

  double totalAll() {
    double _total = 0.0;
    _expe.forEach(
      (expense) {
        _total = _total + expense.amount;
      },
    );
    return _total;
  }

  double totalMonth() {
    double _total = 0.0;
    _expe.forEach(
      (expense) {
        if (expense.date.month == DateTime.now().month)
          _total = _total + expense.amount;
      },
    );
    return _total;
  }

  // Future<String> export() async {
  //   String filePath = await DBHelper.exportAll();
  //   return filePath;
  // }

  // double totalWeek() {
  //   double _total = 0.0;

  //   _expe.forEach(
  //     (expense) {
  //       String date = DateTime.now().toString();
  //       String firstDay = date.substring(0, 8) + '01' + date.substring(10);
  //       int weekDay = DateTime.parse(firstDay).weekday;
  //       // DateTime testDate = DateTime.now();
  //       int weekOfMonth;
  //       weekDay--;
  //       weekOfMonth = ((DateTime.now().day + weekDay) / 7).ceil();
  //       print('Week of the month: $weekOfMonth');
  //       weekDay++;
  //       // if (expense.date.weekday == 1) {
  //       //   _total = _total + expense.amount;
  //       // }
  //     },
  //   );
  //   return _total;
  // }
}
