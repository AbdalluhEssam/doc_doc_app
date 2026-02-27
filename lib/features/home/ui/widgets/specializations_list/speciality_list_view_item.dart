import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/core/theming/colors.dart';
import 'package:doc_doc/core/theming/styles.dart';
import 'package:doc_doc/features/home/data/models/specializations_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SpecialityListViewItem extends StatelessWidget {
  final int index;
  final int selectedSpecializationIndex;
  final SpecializationsData? specializationData;
  const SpecialityListViewItem(
      {super.key,
      required this.index,
      required this.specializationData,
      required this.selectedSpecializationIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 24.w),
      child: Column(
        children: [
          selectedSpecializationIndex == index
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorsManager.darkBlue,
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundColor: ColorsManager.lightBlue,
                    child: SvgPicture.asset(
                      "assets/svgs/general_speciality.svg",
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 28.r,
                  backgroundColor: ColorsManager.lightBlue,
                  child: SvgPicture.asset(
                    "assets/svgs/general_speciality.svg",
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
          verticalSpace(8),
          Text(
            specializationData?.name ?? "Speciality",
            style: selectedSpecializationIndex == index
                ? TextStyles.font14DarkBlueBold
                : TextStyles.font12DarkBlueRegular,
          )
        ],
      ),
    );
  }
}
