import 'package:doc_doc/core/helpers/spacing.dart';
import 'package:doc_doc/features/home/logic/cubit/home_cubit.dart';
import 'package:doc_doc/features/home/logic/cubit/home_state.dart';
import 'package:doc_doc/features/home/ui/widgets/doctors_list/doctors_shimmer_loading.dart';
import 'package:doc_doc/features/home/ui/widgets/specializations_list/speciality_shimmer_loading.dart';
import 'package:doc_doc/features/home/ui/widgets/specializations_list/specialty_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialzationsBlocBuilder extends StatelessWidget {
  const SpecialzationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is SpecializationsLoading ||
          current is SpecializationsSuccess ||
          current is SpecializationsErrorError,
      builder: (context, state) {
        return state.maybeWhen(specializationsLoading: () {
          return setupLoading();
        }, specializationsSuccess: (specializationsResponseModel) {
          var specializationList = specializationsResponseModel;
          return setupSuccess(specializationList);
        }, specializationsError: (apiErrorModel) {
          return setupErrorState();
        }, orElse: () {
          return setupErrorState();
        });
      },
    );
  }

  Widget setupLoading() {
    return Expanded(
      child: Column(
        children: [
          const SpecialityShimmerLoading(),
          verticalSpace(8),
          const DoctorsShimmerLoading(),
        ],
      ),
    );
  }

  Widget setupErrorState() {
    return const Text('Something went wrong');
  }

  Widget setupSuccess(specializationsList) {
    return SpecialtyListView(
      specializationDateList: specializationsList ?? [],
    );
  }
}
