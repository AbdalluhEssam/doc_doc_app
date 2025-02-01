import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/core/theming/colors.dart';
import 'package:doc_doc/features/home/data/models/specializations_response_model.dart';
import 'package:doc_doc/features/home/logic/cubit/home_cubit.dart';
import 'package:doc_doc/features/home/logic/cubit/home_state.dart';
import 'package:doc_doc/features/home/ui/widgets/doctor_specialty_list_view.dart';
import 'package:doc_doc/features/home/ui/widgets/doctors_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialzationsAndDoctorsBlocBuilder extends StatelessWidget {
  const SpecialzationsAndDoctorsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.maybeWhen(specializationsLoading: () {
          return setupLoading();
        }, specializationsSuccess: (specializationsResponseModel) {
          var specializationList = specializationsResponseModel.specializationDataList;
          return setupSuccessState(specializationList);
        }, specializationsError: (apiErrorModel) {
          return setupErrorState();
        }, orElse: () {
          return setupErrorState();
        });
      },
    );
  }

  Widget setupLoading() {
    return const CircularProgressIndicator(
      color: ColorsManager.mainBlue,
    );
  }

  Widget setupErrorState() {
    return const Text('Something went wrong');
  }

  Widget setupSuccessState(specializationList) {
    return Expanded(
      child: Column(
        children: [
          DoctorSpecialtyListView(
            specializationDateList: specializationList ?? [],
          ),
          verticalSpace(8),
          DoctorsListView(
            doctorsList: (specializationList?[0]?.doctorsList ?? [])
                .whereType<Doctors>()
                .toList(),
          ),
        ],
      ),
    );
  }
}
