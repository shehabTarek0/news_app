import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';

Widget buildNewsItem(context, busines) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  '${busines["urlToImage"] ?? "https://i.ibb.co/CQbCYsz/news-default.png"}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      busines['title'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    busines['publishedAt'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget buildArticle(context, list) {
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
        return buildNewsItem(context, list[index]);
      },
    );
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}
