import 'package:doc_doc/features/home/data/models/specializations_response_model.dart';
import 'package:doc_doc/features/home/ui/widgets/doctors_speciality_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSpecialtyListView extends StatelessWidget {
  final List<SpecializationsData?> specializationDateList;
  const DoctorSpecialtyListView(
      {super.key, required this.specializationDateList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: specializationDateList.length,
          itemBuilder: (context, index) => DoctorsSpecialityListViewItem(
                index: index,
                specializationData: specializationDateList[index]!,
              )),
    );
  }
}
