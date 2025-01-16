import 'package:fpdart/src/either.dart';
import 'package:navatech_infinite_album_scroll/core/error/Failure.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/album.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  @override
  Future<Either<Failure, List<Album>>> fetchAlbums() {
    // TODO: implement fetchAlbums
    throw UnimplementedError();
  }

}