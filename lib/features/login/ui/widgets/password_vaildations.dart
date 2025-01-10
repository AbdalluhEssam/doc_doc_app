import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/core/theming/colors.dart';
import 'package:doc_doc/core/theming/styles.dart';
import 'package:flutter/material.dart';

class PasswordValidation extends StatelessWidget {
  final bool hasLowercase;
  final bool hasUppercase;
  final bool hasNumber;
  final bool hasSpecialCharacter;
  final bool hasMinLength;

  const PasswordValidation(
      {super.key,
      required this.hasLowercase,
      required this.hasUppercase,
      required this.hasNumber,
      required this.hasSpecialCharacter,
      required this.hasMinLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow("At least 1 lowercase letter", hasLowercase),
        verticalSpace(2),
        buildValidationRow("At least 1 uppercase letter", hasUppercase),
        verticalSpace(2),
        buildValidationRow("At least 1 special character", hasSpecialCharacter),
        verticalSpace(2),
        buildValidationRow("At least 1 number", hasNumber),
        verticalSpace(2),
        buildValidationRow("At least 8 characters", hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool isValid) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: Colors.grey,
        ),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font13DarkBlueRegular.copyWith(
              decoration: isValid ? TextDecoration.lineThrough : null,
              decorationColor: Colors.green,
              decorationThickness: 2,
              color: isValid ? ColorsManager.gray : ColorsManager.darkBlue),
        ),
      ],
    );
  }
}
