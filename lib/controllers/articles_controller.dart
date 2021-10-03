import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vfocus/models/article.dart';


class ArticlesController extends GetxController {
  var articles = [].obs;

  var apiSearch = "COVID";
  int apiPageSize = 10;
  int apiPage = 1;
  String apiSortBy = "publishedAt";
  String apiKey = "f22218f4587b4655bd011be58635d59d";

  var favouriteArticles = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  void fetchArticles() async {
    final response = await http
      .get(Uri.parse('https://newsapi.org/v2/everything?q=$apiSearch&sortBy=$apiSortBy&pageSize=$apiPageSize&page=$apiPage&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      var jsonArticles = jsonDecode(response.body);
      for (var jsonArticle in jsonArticles["articles"]){
        Article a = Article.fromJson(jsonArticle);
        articles.add(a);
      }
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
