import 'package:doc_doc/features/home/data/models/specializations_response_model.dart';
import 'package:doc_doc/features/home/ui/widgets/doctors_list_view_item.dart';
import 'package:flutter/material.dart';

class DoctorsListView extends StatelessWidget {
  final List<Doctors> doctorsList;
  const DoctorsListView({super.key, required this.doctorsList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: doctorsList.length,
        itemBuilder: (context, index) => DoctorsListViewItem(
          doctorModel: doctorsList[index],
        ),
      ),
    );
  }
}
