import 'package:doc_doc/features/home/data/models/specializations_response_model.dart';
import 'package:doc_doc/features/home/logic/cubit/home_cubit.dart';
import 'package:doc_doc/features/home/ui/widgets/specializations_list/speciality_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialtyListView extends StatefulWidget {
  final List<SpecializationsData?> specializationDateList;
  const SpecialtyListView({super.key, required this.specializationDateList});

  @override
  State<SpecialtyListView> createState() => _SpecialtyListViewState();
}

class _SpecialtyListViewState extends State<SpecialtyListView> {
  var selectedSpecializationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.specializationDateList.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSpecializationIndex = index;
                  });
                  context.read<HomeCubit>().getDoctorsList(
                        specializationId:
                            widget.specializationDateList[index]?.id,
                      );
                },
                child: SpecialityListViewItem(
                  index: index,
                  specializationData: widget.specializationDateList[index],
                  selectedSpecializationIndex: selectedSpecializationIndex,
                ),
              )),
    );
  }
}
