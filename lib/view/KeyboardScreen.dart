import 'package:flutter/material.dart';
import 'package:keyboard2/view/Keyboard.dart';

// import 'Keyboard.dart';


class KeyboardScreen extends StatelessWidget {
  const KeyboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Keyboard(),
    );
  }
}
