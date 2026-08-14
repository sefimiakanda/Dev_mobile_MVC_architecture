import 'package:flutter/material.dart';
import 'controllers/emission_controller.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MonApplication());
}

class MonApplication extends StatelessWidget {
  const MonApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EmissionController emissionController = EmissionController();

    return MaterialApp(
      title: 'Streaming App MVC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(controller: emissionController),
    );
  }
}