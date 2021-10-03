import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:vfocus/controllers/articles_controller.dart';
import 'package:vfocus/models/article.dart';

ArticlesController articlesController = Get.find();

Widget getArticlesListComponent(var articles) {
  return Obx(() => Scrollbar(
          child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return buildArticleCard(context, articles[index], index);
              })));
}

Widget buildArticleCard(BuildContext context, Article article, int index) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(child: Text(article.title),),
        SizedBox(height: 50,)
      ],
    ),
  );
}
