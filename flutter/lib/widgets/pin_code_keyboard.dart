import 'package:biometric_auth_flutter/widgets/pin_code_icon_key.dart';

import 'pin_code_text_key.dart';
import 'package:flutter/material.dart';

class PinCodeKeyboard extends StatelessWidget {
  final void Function(String char) onPressKey;
  final void Function() deleteLastChar;
  final void Function() tryBiometricAuth;
  final bool needShowBiometricButton;

  const PinCodeKeyboard({
    Key? key,
    required this.onPressKey,
    required this.deleteLastChar,
    required this.tryBiometricAuth,
    required this.needShowBiometricButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          PinCodeTextKey(
            value: '1',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '2',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '3',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '4',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '5',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '6',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '7',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '8',
            onPress: onPressKey,
          ),
          PinCodeTextKey(
            value: '9',
            onPress: onPressKey,
          ),
          needShowBiometricButton
              ? PinCodeIconKey(
                  path: 'face_id_icon',
                  onPress: tryBiometricAuth,
                )
              : const SizedBox(),
          PinCodeTextKey(
            value: '0',
            onPress: onPressKey,
          ),
          PinCodeIconKey(
            path: 'delete_icon',
            onPress: deleteLastChar,
          ),
        ],
      ),
    );
  }
}

const pinCodeKeys = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  'face_id_icon',
  '0',
  'delete_icon'
];
