import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfocus/components/article_components.dart';
import 'package:vfocus/controllers/articles_controller.dart';

class HomePage extends StatelessWidget {
  ArticlesController articlesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const TabBar(
                tabs: [
                  Tab(text: "All"),
                  Tab(text: "Bookmarks")
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            getArticlesListComponent(articlesController.articles),
            Center(child: Text("Bookmarks"))
          ],
        ),
      ),
    );
  }
}
