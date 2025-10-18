import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/core/helper/validator_helper.dart';
import 'package:flutter_testing_lab/widgets/form_input_field.dart';

class NameInputField extends StatelessWidget {
  final TextEditingController controller;

  const NameInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FormInputField(
      label: 'Full Name',
      controller: controller,
      validator: ValidatorHelper.validateName,
    );
  }
}
