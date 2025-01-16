import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:navatech_infinite_album_scroll/common/constants.dart';
import 'package:navatech_infinite_album_scroll/core/error/Failure.dart';
import 'package:navatech_infinite_album_scroll/core/error/server_exception.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/photo.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final Dio dio;
  final Connectivity connectivity;

  PhotoRepositoryImpl({required this.dio, required this.connectivity});

  @override
  Future<Either<Failure, List<Photo>>> fetchPhotos(int albumId) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();

      if (!connectivityResult.contains(ConnectivityResult.none)) {
        final response = await dio.get('${Constants.baseUrl}/photos',
            queryParameters: {'albumId': albumId});
        final photos = (response.data as List)
            .map((json) => Photo.fromJson(json))
            .toList();
        return Either.right(photos);
      }
      return Either.right([]);
    } on ServerException catch (e) {
      return Either.left(
        Failure(e.message),
      );
    }
  }
}
