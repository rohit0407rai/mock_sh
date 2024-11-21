
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sih_finals/screens/auth_screen/bloc/auth/auth_bloc.dart';
import 'package:sih_finals/screens/auth_screen/bloc/register/register_bloc.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_colors.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>RegisterBloc()),
          BlocProvider(create: (context)=>AuthenticationBloc()),
        ],
        child: MaterialApp.router(
            title: 'stromlesser',
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
            ),
          ),
      ),
    );
  }
}
