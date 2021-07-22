import 'package:flutter/material.dart';
import 'package:expe/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:expe/providers/expe.dart' as xp;

void main() => runApp(Expe());

class Expe extends StatelessWidget {
  final String title = "Expe";
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => xp.Expe(),
        ),
      ],
      child: MaterialApp(
        title: "$title",
        // debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryColor: Color(0xff00b2bb),
          accentColor: Color(0xff79d2a6),
          fontFamily: 'Rubik',
        ),
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
