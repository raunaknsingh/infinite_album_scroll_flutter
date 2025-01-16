import 'package:fpdart/fpdart.dart';

import '../../core/error/Failure.dart';
import '../entity/photo.dart';

abstract interface class PhotoRepository {
  Future<Either<Failure, List<Photo>>> fetchPhotos(int albumId);
}