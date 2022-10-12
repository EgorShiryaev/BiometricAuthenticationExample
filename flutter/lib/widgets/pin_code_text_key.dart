import 'package:flutter/material.dart';

class PinCodeTextKey extends StatelessWidget {
  final String value;
  final void Function(String v) onPress;
  const PinCodeTextKey({
    Key? key,
    required this.value,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(value),
      splashColor: Colors.white,
      overlayColor: MaterialStateProperty.all(Colors.white),
      highlightColor: Colors.white,
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 40 * MediaQuery.of(context).textScaleFactor,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
