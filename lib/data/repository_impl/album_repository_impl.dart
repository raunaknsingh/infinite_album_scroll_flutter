import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:navatech_infinite_album_scroll/common/constants.dart';
import 'package:navatech_infinite_album_scroll/core/error/failure.dart';
import 'package:navatech_infinite_album_scroll/core/error/server_exception.dart';
import 'package:navatech_infinite_album_scroll/data/local/local_storage.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/album.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final Dio dio;
  final Connectivity connectivity;
  final LocalStorage localStorage;

  AlbumRepositoryImpl({
    required this.dio,
    required this.connectivity,
    required this.localStorage,
  });

  @override
  Future<Either<Failure, List<Album>>> fetchAlbums() async {
    final albumBox = localStorage.getAlbumBox();
    final cachedAlbums = albumBox.values.toList();
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        final response = await dio.get('${Constants.baseUrl}/albums');
        final albums = (response.data as List)
            .map((json) => Album.fromJson(json))
            .toList();
        albumBox.clear();
        albumBox.addAll(albums);
        return Either.right(
          albums,
        );
      }
      return Either.right(cachedAlbums);
    } on ServerException catch (e) {
      return Either.left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
