import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FormInputField extends HookWidget {
  final String label;
  final String? helperText;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final TextEditingController controller;

  const FormInputField({
    super.key,
    required this.label,
    this.helperText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(!isPassword);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        border: const OutlineInputBorder(),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isVisible.value ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => isVisible.value = !isVisible.value,
              )
            : null,
      ),
      obscureText: isPassword && !isVisible.value,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
