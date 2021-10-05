
import 'package:hive/hive.dart';

part 'source.g.dart';

@HiveType(typeId: 2)
class Source {
    Source({
        this.id,
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