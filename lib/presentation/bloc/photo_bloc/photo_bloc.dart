import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/photo_repository.dart';

import '../../../domain/entity/photo.dart';

part 'photo_event.dart';

part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository photoRepository;

  PhotoBloc(this.photoRepository) : super(PhotoInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotoLoading());
      final photosResponse = await photoRepository.fetchPhotos(event.albumId);

      photosResponse.fold(
        (failure) => emit(
          PhotoError(failure.errorMessage),
        ),
        (photos) => emit(
          PhotoLoaded(photos),
        ),
      );
    });
  }
}
