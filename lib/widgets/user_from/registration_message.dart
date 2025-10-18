import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegistrationMessage extends StatelessWidget {
  final String message;

  const RegistrationMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        const Gap(16),
        Text(
          message,
          style: TextStyle(
            color: message.contains('successful') ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
