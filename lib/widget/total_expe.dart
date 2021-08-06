import 'package:flutter/material.dart';
import 'package:expe/providers/expe.dart';

class TotalExpe extends StatelessWidget {
  final Expe expe;
  const TotalExpe({
    Key? key,
    required this.expe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.2, 0.7],
          colors: [
            Color(0xff00b2bb),
            Color(0xff79d2a6),
          ],
        ),
      ),
      height: MediaQuery.of(context).size.height * .40,
      padding: EdgeInsets.only(top: 20, left: 30, right: 20),
      child: PageView(
        children: <Widget>[
          Total(label: 'Monthly Expense', total: expe.totalMonth()),
          Total(label: 'Total Expense', total: expe.totalAll()),
          // Total(label: 'Weekly Expense', total: expe.totalWeek()),
        ],
      ),
    );
  }
}

class Total extends StatelessWidget {
  const Total({
    Key? key,
    required this.label,
    required this.total,
  }) : super(key: key);

  final double total;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Text(
          total.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 34.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}
