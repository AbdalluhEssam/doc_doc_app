import 'package:doc_doc/core/di/dependency_injection.dart';
import 'package:doc_doc/core/helpers/constants.dart';
import 'package:doc_doc/core/helpers/extentions.dart';
import 'package:doc_doc/core/helpers/shared_pref_helper.dart';
import 'package:doc_doc/doc_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await checkIfLoggedInUser();
  setupGetIt();
  runApp(DocApp(appRouter: AppRouter()));
}

checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}