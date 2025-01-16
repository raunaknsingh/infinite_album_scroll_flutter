import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/album.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/photo.dart';

class LocalStorage {
  static const String albumBox = 'albums';
  static const String photoBox = 'photos';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AlbumAdapter());
    Hive.registerAdapter(PhotoAdapter());
    await Hive.openBox<Album>(albumBox);
    await Hive.openBox<List<dynamic>>(photoBox);
  }

  Box<Album> getAlbumBox() => Hive.box<Album>(albumBox);
  Box<List<dynamic>> getPhotoBox() => Hive.box<List<dynamic>>(photoBox);
}