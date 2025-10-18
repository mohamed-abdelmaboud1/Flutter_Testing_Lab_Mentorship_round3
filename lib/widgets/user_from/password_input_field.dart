import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/core/helper/validator_helper.dart';
import 'package:flutter_testing_lab/widgets/form_input_field.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FormInputField(
      label: 'Password',
      controller: controller,
      isPassword: true,
      validator: ValidatorHelper.validateRegisterPassword,
    );
  }
}
