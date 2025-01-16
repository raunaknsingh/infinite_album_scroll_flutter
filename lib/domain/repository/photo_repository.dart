import 'package:fpdart/fpdart.dart';

import '../../core/error/failure.dart';
import '../entity/photo.dart';

abstract interface class PhotoRepository {
  Future<Either<Failure, List<Photo>>> fetchPhotos(int albumId);
}