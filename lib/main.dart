import 'package:abha_api/Homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AbhaLoginPage());
}

class AbhaLoginPage extends StatefulWidget {
  const AbhaLoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AbhaLoginPageState();
  }
}

class _AbhaLoginPageState extends State<AbhaLoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Abha API'),
          backgroundColor: Colors.blue,
        ),
        body: const Homepage(),
      ),
    );
  }
}
