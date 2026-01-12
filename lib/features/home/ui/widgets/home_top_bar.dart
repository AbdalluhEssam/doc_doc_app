import 'package:doc_doc/core/theming/colors.dart';
import 'package:doc_doc/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi , Abdallah!",
              style: TextStyles.font18DarkBlueBold,
            ),
            Text(
              "How Are you Today?",
              style: TextStyles.font12GrayRegular,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 24,
          backgroundColor: ColorsManager.moreLighterGray,
          child: SvgPicture.asset("assets/svgs/notifications.svg"),
        )
      ],
    );
  }
}
