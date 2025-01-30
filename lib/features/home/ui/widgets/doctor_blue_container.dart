import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorBlueContainer extends StatelessWidget {
  const DoctorBlueContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 165.h,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
                // color: ColorsManager.mainBlue,
                borderRadius: BorderRadius.circular(24.r),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/home_blue_pattern.png"))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Book and\nschedule with\nnearest doctor",
                  style: TextStyles.font18WhiteMedium,
                  textAlign: TextAlign.start,
                ),
                verticalSpace(8),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48.r)),
                        // minimumSize: Size(double.maxFinite, 40.h)
                      ),
                      child: Text(
                        "Find Doctor",
                        style: TextStyles.font12BlueRegular,
                      )),
                )
              ],
            ),
          ),
          Positioned(
            top: 0.h,
            right: 8.w,
            child: Image.asset(
              "assets/images/doc.png",
              height: 200.h,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
