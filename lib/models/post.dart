// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:vfocus/models/source.dart';

part 'post.g.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class Post {
    Post({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    @HiveField(0)
    Source source;

    @HiveField(1)
    String author;

    @HiveField(2)
    String title;

    @HiveField(3)
    String description;

    @HiveField(4)
    String url;

    @HiveField(5)
    String? urlToImage;

    @HiveField(6)
    DateTime publishedAt;

    @HiveField(7)
    String content;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
    };
}

