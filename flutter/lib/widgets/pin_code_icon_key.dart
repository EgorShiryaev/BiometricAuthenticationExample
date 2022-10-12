import 'package:flutter/material.dart';

class PinCodeIconKey extends StatelessWidget {
  final String path;
  final void Function() onPress;
  const PinCodeIconKey({
    Key? key,
    required this.path,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = 40 * MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: onPress,
      splashColor: Colors.white,
      overlayColor: MaterialStateProperty.all(Colors.white),
      highlightColor: Colors.white,
      child: Center(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Image.asset(
            'assets/$path.png',
          ),
        ),
      ),
    );
  }
}
