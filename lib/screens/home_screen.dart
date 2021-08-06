import 'package:expe/widget/app_drawer.dart';
import 'package:expe/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expe/widget/expenses.dart';
import 'package:expe/widget/total_expe.dart';
import 'package:expe/providers/expe.dart';
import 'package:expe/models/expense.dart' as xp;

class HomeScreen extends StatelessWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _addExpense(
      String name,
      double amount,
      DateTime date,
    ) {
      final Expe _expe = Provider.of<Expe>(
        context,
        listen: false,
      );
      final xp.Expense _newExpe = xp.Expense(
        DateTime.now().toString(),
        name,
        amount,
        date,
      );
      _expe.newExpense(_newExpe);
    }

    // Future _refreshData() async {
    //   // await Future.delayed(Duration(seconds: 3));
    //   // _data.clear();
    //   // _data.addAll(generateWordPairs().take(20));
    //   setState(() {});
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Provider.of<Expe>(context).setExpenses(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<Expe>(
                    builder: (ctx, expe, _) {
                      return Stack(
                        children: <Widget>[
                          TotalExpe(expe: expe),
                          Expenses(expe: expe),
                        ],
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: NewExpense(_addExpense),
              );
            },
          );
        },
        child: Icon(
          Icons.add_rounded,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
