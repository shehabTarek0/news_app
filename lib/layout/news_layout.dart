import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

class NewsLayoutScreen extends StatelessWidget {
  const NewsLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()
          ..getBusiness()
          ..getSports()
          ..getScience(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: ((context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Elgarida'),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_sharp,
                        size: 28,
                      ))
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: const Color.fromARGB(255, 202, 56, 3),
                backgroundColor: Colors.white,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.business_center_sharp),
                      label: 'Busniness'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sports), label: 'Sports'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.science_rounded), label: 'Science'),
                ],
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (value) {
                  AppCubit.get(context).changeBottomNavBar(value);
                },
              ),
              body: AppCubit.get(context)
                  .screens[AppCubit.get(context).currentIndex],
            );
          }),
          listener: (context, state) {},
        ));
  }
}
