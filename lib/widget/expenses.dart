import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expe/providers/expe.dart';

class Expenses extends StatelessWidget {
  final Expe expe;
  Expenses({
    Key? key,
    required this.expe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: new EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .3,
        right: 20.0,
        left: 20.0,
      ),
      child: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: expe.expe.length,
          primary: false,
          itemBuilder: (ctx, i) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Expense(
                  id: expe.expe[i].id,
                  name: expe.expe[i].name,
                  amount: expe.expe[i].amount,
                  date: expe.expe[i].date,
                  delete: expe.removeExpense,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Expense extends StatelessWidget {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Function(String) delete;
  Expense({
    Key? key,
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(id),
      onDismissed: (_) {
        delete(id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Deleted',
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 20.0),
                child: Text(
                  "$amount",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                    Text(DateFormat.yMMMd().format(date)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
