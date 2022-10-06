// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDarkMain;
  if (CacheHelper.getData(key: 'isDark') == null) {
    isDarkMain = false;
  } else {
    isDarkMain = CacheHelper.getData(key: 'isDark');
  }

  runApp(MyApp(isDarkMain));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()
          ..changeThemeApp(fromCache: isDark)
          ..getBusiness()
          ..getSports()
          ..getScience(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 26,
                    letterSpacing: .7,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color.fromARGB(255, 5, 5, 5),
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Color.fromARGB(255, 202, 56, 3),
                  type: BottomNavigationBarType.fixed,
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 5, 5, 5),
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color.fromARGB(255, 5, 5, 5),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    fontSize: 26,
                    letterSpacing: .7,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                scaffoldBackgroundColor: const Color.fromARGB(255, 5, 5, 5),
              ),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const NewsLayoutScreen(),
            );
          },
          listener: (context, state) {},
        ));
  }
}
