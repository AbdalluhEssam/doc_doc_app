import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/features/home/ui/widgets/doctor_blue_container.dart';
import 'package:doc_doc/features/home/ui/widgets/doctor_speciality_see_all.dart';
import 'package:doc_doc/features/home/ui/widgets/doctor_specialty_list_view.dart';
import 'package:doc_doc/features/home/ui/widgets/doctors_list_view.dart';
import 'package:doc_doc/features/home/ui/widgets/home_top_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          // width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const DoctorBlueContainer(),
              verticalSpace(24),
              const DoctorSpecialitySeeAll(),
              verticalSpace(18),
              const DoctorSpecialtyListView(),
              verticalSpace(8),
              const DoctorsListView(),
            ],
          ),
        ),
      ),
    );
  }
}
