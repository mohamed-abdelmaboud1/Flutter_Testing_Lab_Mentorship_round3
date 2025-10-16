import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/core/helper/validator_helper.dart';
import 'package:flutter_testing_lab/widgets/form_input_field.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;

  const EmailInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FormInputField(
      label: 'Email',
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: ValidatorHelper.validateEmail,
    );
  }
}
