import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsListView extends StatelessWidget {
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://static.wikia.nocookie.net/five-world-war/images/6/64/Hisoka.jpg/revision/latest?cb=20190313114050",
                // progressIndicatorBuilder: (context, url, downloadProgress) {
                //   // return Shimmer.fromColors(
                //   //   baseColor: ColorsManager.lightGray,
                //   //   highlightColor: Colors.white,
                //   //   child: Container(
                //   //     width: 110.w,
                //   //     height: 120.h,
                //   //     decoration: BoxDecoration(
                //   //       shape: BoxShape.rectangle,
                //   //       borderRadius: BorderRadius.circular(12.0),
                //   //       color: Colors.white,
                //   //     ),
                //   //   ),
                //   // );
                // },
                imageBuilder: (context, imageProvider) => Container(
                  width: 110.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Abdalluh Essam',
                      style: TextStyles.font18DarkBlueBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(5),
                    Text(
                      'Degree | 0100061819',
                      style: TextStyles.font12GrayMedium,
                    ),
                    verticalSpace(5),
                    Text(
                      'abdallh.essam@gmail.com',
                      style: TextStyles.font12GrayMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
