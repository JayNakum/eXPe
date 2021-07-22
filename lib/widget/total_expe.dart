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
    return Column(
      children: <Widget>[
        Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Total Expenses",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                expe.total().toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
