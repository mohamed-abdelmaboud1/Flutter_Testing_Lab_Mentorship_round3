import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_testing_lab/widgets/user_from/confirm_password_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/email_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/name_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/password_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/registration_message.dart';
import 'package:flutter_testing_lab/widgets/user_from/registration_submit_button.dart';
import 'package:gap/gap.dart';

class UserRegistrationForm extends HookWidget {
  const UserRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final autovalidateMode = useState(AutovalidateMode.onUserInteraction);
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final isLoading = useState(false);
    final message = useState('');

    Future<void> submitForm() async {
      if (!formKey.currentState!.validate()) {
        autovalidateMode.value = AutovalidateMode.always;
        return;
      }

      isLoading.value = true;
      message.value = '';

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;
      message.value = 'Registration successful!';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NameInputField(controller: nameController),
            const Gap(16),
            EmailInputField(controller: emailController),
            const Gap(16),
            PasswordInputField(controller: passwordController),
            const Gap(16),
            ConfirmPasswordInputField(
              controller: confirmPasswordController,
              passwordController: passwordController,
            ),
            const Gap(24),
            RegistrationSubmitButton(
              isLoading: isLoading.value,
              onPressed: isLoading.value ? null : submitForm,
            ),
            RegistrationMessage(message: message.value),
          ],
        ),
      ),
    );
  }
}
