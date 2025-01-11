import 'package:dio/dio.dart';
import 'package:doc_doc/core/networking/api_service.dart';
import 'package:doc_doc/features/login/logic/login_cubit.dart';
import 'package:doc_doc/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:doc_doc/features/sign_up/logic/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/data/repos/login_repo.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio),);


  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt<ApiService>()),);
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepo>()),);

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt<ApiService>()),);
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt<SignupRepo>()),);

}