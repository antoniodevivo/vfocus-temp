import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:vfocus/features/news/data/models/article_model.dart';

part 'source_model.g.dart';

ArticleModel soruceModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String sourceModelToJson(ArticleModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class Source {
    Source({
        required this.id,
        required this.name,
    });

    @HiveField(0)
    String? id;

    @HiveField(1)
    String? name;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}