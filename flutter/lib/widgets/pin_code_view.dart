import 'package:flutter/material.dart';

class PinCodeView extends StatelessWidget {
  final int pinCodeLenght;
  const PinCodeView({Key? key, required this.pinCodeLenght}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        4,
        (index) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: index >= pinCodeLenght ? Colors.grey : Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
