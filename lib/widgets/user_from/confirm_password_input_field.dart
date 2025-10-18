import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/core/helper/validator_helper.dart';
import 'package:flutter_testing_lab/widgets/form_input_field.dart';

class ConfirmPasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;

  const ConfirmPasswordInputField({
    super.key,
    required this.controller,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return FormInputField(
      label: 'Confirm Password',
      controller: controller,
      isPassword: true,
      validator: (value) => ValidatorHelper.validateConfirmPassword(
        passwordController.text,
        value,
      ),
    );
  }
}
