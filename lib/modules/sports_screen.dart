import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var list = AppCubit.get(context).sports;
        if (list.isNotEmpty) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 1.2,
                indent: 20,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return buildNewsItem(list[index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      listener: (context, state) {},
    );
  }
}
