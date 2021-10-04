import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:vfocus/models/article.dart';


class ArticlesController extends GetxController {
  var articles = [].obs;

  var apiSearch = "COVID";
  int apiPageSize = 10;
  int apiPage = 1;
  String apiSortBy = "publishedAt";
  String apiKey = "f22218f4587b4655bd011be58635d59d";
  var listIsEnded = false.obs;

  var favouriteArticles = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void addArticleToBookmarks(Article article) {
    final articlesBox = Hive.box('articles');
    articlesBox.add(article);
    favouriteArticles.add(article);
  }

  void removeArticleToBookmarks(Article article) {
    final articlesBox = Hive.box('articles');
    articlesBox.delete(article);
    favouriteArticles.remove(article);
  }

  void fetchArticles() async {
    if (listIsEnded.value)
      return;

    final response = await http
      .get(Uri.parse('https://newsapi.org/v2/everything?q=$apiSearch&sortBy=$apiSortBy&pageSize=$apiPageSize&page=$apiPage&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      var jsonArticles = jsonDecode(response.body);
      for (var jsonArticle in jsonArticles["articles"]){
        Article a = Article.fromJson(jsonArticle);
        articles.add(a);
      }
      apiPage++;
    } else if (response.statusCode == 426) {
      listIsEnded.value = true;
      update();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
