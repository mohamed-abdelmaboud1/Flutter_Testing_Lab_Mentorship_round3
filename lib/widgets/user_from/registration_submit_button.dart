import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/core/constant/keys.dart';

class RegistrationSubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const RegistrationSubmitButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key(Keys.registrationSubmitButton),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),

      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text('Register'),
    );
  }
}
