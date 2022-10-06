import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var list = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Search',
                    labelStyle: TextStyle(
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppCubit.get(context).isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  onChanged: (value) {
                    AppCubit.get(context).getSearch(value: value);
                  },
                ),
                Expanded(child: buildArticle(context, list)),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
