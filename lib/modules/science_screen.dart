import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var list = AppCubit.get(context).science;
        if (list.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
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
        }
      },
      listener: (context, state) {},
    );
  }
}
