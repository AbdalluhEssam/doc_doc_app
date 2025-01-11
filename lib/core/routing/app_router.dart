import 'package:doc_doc/core/di/dependency_injection.dart';
import 'package:doc_doc/core/routing/routes.dart';
import 'package:doc_doc/features/home/ui/home_screen.dart';
import 'package:doc_doc/features/login/logic/login_cubit.dart';
import 'package:doc_doc/features/login/ui/login_screen.dart';
import 'package:doc_doc/features/onboarding/onboarding_screen.dart';
import 'package:doc_doc/features/sign_up/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/sign_up/logic/sign_up_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // this arguments is optional
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<LoginCubit>(),
                  child: const LoginScreen(),
                ));
      case Routes.signupScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => getIt<SignupCubit>(),
                  child:const SignupScreen(),
                ));
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
