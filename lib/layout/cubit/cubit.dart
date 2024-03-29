import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  int currentIndex = 0;
  bool isDark = false;
  void changeThemeApp({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeThemeDataState());
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeDataState());
      });
    }
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List business = [];

  void getBusiness() {
    emit(AppLoadingGetBusinessState());
    DioHelper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'a2563339bbb64fadbb837fdaf3cf768c',
    }).then((value) {
      business = value.data['articles'];
      emit(AppSuccessGetBusinessState());
    }).catchError((e) {
      emit(AppErrorGetBusinessState());
    });
  }

  List sports = [];

  void getSports() {
    emit(AppLoadingGetSportsState());
    DioHelper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'a2563339bbb64fadbb837fdaf3cf768c',
    }).then((value) {
      sports = value.data['articles'];
      emit(AppSuccessGetSportsState());
    }).catchError((e) {
      emit(AppErrorGetSportsState());
    });
  }

  List science = [];

  void getScience() {
    emit(AppLoadingGetScienceState());
    DioHelper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'a2563339bbb64fadbb837fdaf3cf768c',
    }).then((value) {
      science = value.data['articles'];
      emit(AppSuccessGetScienceState());
    }).catchError((e) {
      emit(AppErrorGetScienceState());
    });
  }

  List search = [];

  void getSearch({required String value}) {
    emit(AppLoadingGetSearchState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': 'a2563339bbb64fadbb837fdaf3cf768c',
    }).then((value) {
      search = value.data['articles'];
      emit(AppSuccessGetSearchState());
    }).catchError((e) {
      emit(AppErrorGetSearchState());
    });
  }
}
