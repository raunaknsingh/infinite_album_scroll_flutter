import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:navatech_infinite_album_scroll/common/constants.dart';
import 'package:navatech_infinite_album_scroll/core/error/Failure.dart';
import 'package:navatech_infinite_album_scroll/core/error/server_exception.dart';
import 'package:navatech_infinite_album_scroll/data/local/local_storage.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/photo.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final Dio dio;
  final Connectivity connectivity;
  final LocalStorage localStorage;

  PhotoRepositoryImpl({required this.dio, required this.connectivity, required this.localStorage});

  @override
  Future<Either<Failure, List<Photo>>> fetchPhotos(int albumId) async {
    final photoBox = localStorage.getPhotoBox();

    final photos = photoBox.get(albumId, defaultValue: []);
    final cachedPhotos = _parseCachedPhotos(photos);
    try {
      final connectivityResult = await connectivity.checkConnectivity();

      if (!connectivityResult.contains(ConnectivityResult.none)) {
        final response = await dio.get('${Constants.baseUrl}/photos',
            queryParameters: {'albumId': albumId});
        final photos = (response.data as List)
            .map((json) => Photo.fromJson(json))
            .toList();
        photoBox.put(albumId, photos);
        return Either.right(photos);
      }
      return Either.right(cachedPhotos);
    } on ServerException catch (e) {
      return Either.left(
        Failure(e.message),
      );
    }
  }

  List<Photo> _parseCachedPhotos(dynamic cachedData) {
    try {
      if (cachedData is List) {
        return cachedData.cast<Photo>();
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
