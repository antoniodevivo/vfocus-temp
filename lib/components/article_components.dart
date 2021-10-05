import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:vfocus/controllers/articles_controller.dart';
import 'package:vfocus/models/article.dart';

ArticlesController articlesController = Get.find();

Widget getArticlesListHomePageComponent(var articles) {
  return Obx(() => Scrollbar(
      child: ListView.builder(
          itemCount: articles.length + 1,
          itemBuilder: (context, index) {
            if (index < articles.length) {
              return buildArticleCard(context, articles[index], index);
            } else {
              return GetBuilder<ArticlesController>(
                  builder: (pc) => Stack(
                        children: [
                          if (!articlesController.listIsEnded.value)
                            Container(
                              child: Center(
                                child: OutlinedButton(
                                  child: Text("Load more data"),
                                  onPressed: () {
                                    articlesController.fetchArticles();
                                  },
                                ),
                              ),
                            )
                          else
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Center(child: Text("Nothing more to load")),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                        ],
                      ));
            }
          })));
}

Widget getArticlesListBookmarkPageComponent(var articles) {
  return Obx(() => Scrollbar(

      child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            if(articles.length > 0)
              return buildArticleCard(context, articles[index], index);
            else
              return Expanded(
                child: Container(
                  height: 60,
                  child: Center(
                    child: Text("No bookmarks here")
                  ),
                ),
              );
          })));
}

Widget buildArticleCard(BuildContext context, Article article, int index) {
  return Card(

    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(article.title ??= ""),
          subtitle: Text(article.description ??= ""),
          trailing: Wrap(
            children: <Widget>[
              GetBuilder<ArticlesController>(
                  builder: (pc) {
                    if ( articlesController.favouriteArticles.firstWhere((element) => element.url == article.url, orElse: () => null) != null )
                      return IconButton(
                        icon: const Icon(Icons.bookmark),
                        tooltip: 'Remove bookmark',
                        onPressed: () {
                          articlesController.removeArticleToBookmarks(article);
                        },
                      );
                    else
                      return IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        tooltip: 'Add bookmark',
                        onPressed: () {
                          articlesController.addArticleToBookmarks(article);
                        },
                      );
                  })
              
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
