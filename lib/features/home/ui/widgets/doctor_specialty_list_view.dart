import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/core/theming/colors.dart';
import 'package:doc_doc/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorSpecialtyListView extends StatelessWidget {
  const DoctorSpecialtyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 24.w),
          child: Column(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: ColorsManager.lightBlue,
                child: SvgPicture.asset(
                  "assets/svgs/general_speciality.svg",
                  height: 40.h,
                  width: 40.w,
                ),
              ),
              verticalSpace(8),
              Text(
                "Speciality",
                style: TextStyles.font12DarkBlueRegular,
              )
            ],
          ),
        ),
      ),
    );
  }
}
