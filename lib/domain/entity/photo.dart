import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Photo {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String url;

  Photo({required this.id, required this.title, required this.url});

}