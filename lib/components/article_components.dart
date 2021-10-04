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

Widget buildArticleCard(BuildContext context, Article article, int index) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Text(article.title),
        ),
        SizedBox(
          height: 50,
        )
      ],
    ),
  );
}
