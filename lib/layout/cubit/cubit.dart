import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
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

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List business = [];

  void getBusiness() {
    emit(AppLoadingGetBusinessState());
    DioHelper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '9917fb7dbd8c4f4cb2d43f401f7410e8',
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
      'apiKey': '9917fb7dbd8c4f4cb2d43f401f7410e8',
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
      'country': 'us',
      'category': 'science',
      'apiKey': '9917fb7dbd8c4f4cb2d43f401f7410e8',
    }).then((value) {
      science = value.data['articles'];
      emit(AppSuccessGetScienceState());
    }).catchError((e) {
      emit(AppErrorGetScienceState());
    });
  }
}
