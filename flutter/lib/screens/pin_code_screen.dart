import 'package:biometric_auth_flutter/screens/home_screen.dart';
import 'package:biometric_auth_flutter/widgets/pin_code_keyboard.dart';
import 'package:biometric_auth_flutter/widgets/pin_code_view.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String code = '';
  final LocalAuthentication auth = LocalAuthentication();

  bool? deviceIsSupportBiometricAuth;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        deviceIsSupportBiometricAuth = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              flex: 1,
              child: SizedBox.expand(),
            ),
            Flexible(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Center(
                      child: PinCodeView(
                        pinCodeLenght: code.length,
                      ),
                    ),
                  ),
                  Builder(builder: (_) {
                    if (deviceIsSupportBiometricAuth == null) {
                      return AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return PinCodeKeyboard(
                      onPressKey: addCodeCharacter,
                      deleteLastChar: deleteLastCharacter,
                      tryBiometricAuth: tryBiometricAuth,
                      needShowBiometricButton: deviceIsSupportBiometricAuth!,
                    );
                  })
                ],
              ),
            ),
            const Flexible(
              flex: 1,
              child: SizedBox.expand(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToHomeScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void addCodeCharacter(String char) {
    if (code.length == 3) {
      _navigateToHomeScreen();
      setState(() {
        code = '';
      });
    } else {
      setState(() {
        code = code + char;
      });
    }
  }

  void deleteLastCharacter() {
    if (code.isEmpty) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
    });
  }

  void tryBiometricAuth() {
    auth
        .authenticate(
      localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),
    )
        .then((value) {
      if (value) {
        _navigateToHomeScreen();
      }
    });
  }
}
