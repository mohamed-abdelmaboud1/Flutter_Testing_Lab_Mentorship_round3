import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/core/helper/validator_helper.dart';

void main() {
  group('ValidatorHelper', () {
    test('validateEmail returns null for valid email', () {
      final emailValid = ValidatorHelper.validateEmail('abdoX@Mentorship.com');
      expect(emailValid, null);
    });
    test('validateEmail returns error for empty email', () {
      final emailEmpty = ValidatorHelper.validateEmail('');
      final msg = 'Please enter your email';
      expect(emailEmpty, msg);
    });

    test('validateEmail returns error for invalid email', () {
      final emailNotValid = ValidatorHelper.validateEmail('lol');
      final msg2 = 'Please enter a valid email';
      expect(emailNotValid, msg2);
    });

    test('validateName returns null for valid name', () {
      final nameResult = ValidatorHelper.validateName('John Doe');
      expect(nameResult, null);
    });
    test('validateName returns error for empty name', () {
      final nameEmpty = ValidatorHelper.validateName('');
      final msg = 'Please enter your name';
      expect(nameEmpty, msg);
    });

    test('validateRegisterPassword returns error for short password', () {
      final passwordShort = ValidatorHelper.validateRegisterPassword('Abc1!');
      final msg3 = 'Password is too short';
      expect(passwordShort, msg3);
    });
    test('validateRegisterPassword returns null for valid password', () {
      final passwordValid = ValidatorHelper.validateRegisterPassword(
        'Abcd1234!',
      );
      expect(passwordValid, null);
    });
  });
}
