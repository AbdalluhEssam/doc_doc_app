import 'package:doc_doc/core/di/dependency_injection.dart';
import 'package:doc_doc/doc_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setupGetIt();
  runApp(DocApp(appRouter: AppRouter()));
}
// 1//03JbeMaVai41cCgYIARAAGAMSNwF-L9Ir92h_mBiPfixbyGV560yS_VqJ_9GQgavqS07ABBtEHDOe4VbqbMJZecL4dAeIc3w9jR4
// Make app Destrobtion
