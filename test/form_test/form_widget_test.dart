import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/core/constant/keys.dart';
import 'package:flutter_testing_lab/widgets/user_from/confirm_password_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/email_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/name_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/password_input_field.dart';
import 'package:flutter_testing_lab/widgets/user_from/registration_message.dart';
import 'package:flutter_testing_lab/widgets/user_from/user_registration_form.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(find.byType(NameInputField), 'Mohamed');
    await tester.enterText(find.byType(EmailInputField), 'abdoX@edu.com');
    await tester.enterText(find.byType(PasswordInputField), '123456M#');
    await tester.enterText(find.byType(ConfirmPasswordInputField), '123456M#');
    await tester.tap(find.byKey(const Key(Keys.registrationSubmitButton)));
    await tester.pumpAndSettle();
    expect(find.text('0'), findsNothing);
    expect(find.text('Register'), findsOneWidget);
    expect(find.byType(RegistrationMessage), findsOneWidget);
  });
}
