import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Album {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  Album({required this.id, required this.title,});
}