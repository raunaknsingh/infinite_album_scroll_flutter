import 'package:fpdart/fpdart.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/album.dart';

import '../../core/error/failure.dart';

abstract interface class AlbumRepository {
  Future<Either<Failure, List<Album>>> fetchAlbums();
}