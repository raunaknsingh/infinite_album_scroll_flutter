import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:navatech_infinite_album_scroll/common/constants.dart';
import 'package:navatech_infinite_album_scroll/core/error/Failure.dart';
import 'package:navatech_infinite_album_scroll/core/error/server_exception.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/album.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final Dio dio;
  final Connectivity connectivity;

  AlbumRepositoryImpl({required this.dio, required this.connectivity});

  @override
  Future<Either<Failure, List<Album>>> fetchAlbums() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        final response = await dio.get('${Constants.baseUrl}/albums');
        final albums = (response.data as List)
            .map((json) => Album.fromJson(json))
            .toList();
        return Either.right(
          albums,
        );
      }
      return Either.right([]); // TODO remove after caching logic
    } on ServerException catch (e) {
      return Either.left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
