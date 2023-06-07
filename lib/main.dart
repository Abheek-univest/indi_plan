import 'package:flutter/material.dart';
import 'package:indi_plans/page.dart';

void main() => runApp(const Myapp());

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff000000),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Univest')),
        body: indiplans(),
      ),
    );
  }
}