import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/album_repository.dart';

import '../../../domain/entity/album.dart';

part 'album_event.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository albumRepository;

  AlbumBloc(this.albumRepository) : super(AlbumInitial()) {
    on<AlbumEvent>((event, emit) async {
      emit(AlbumLoading());
      final albumsResponse = await albumRepository.fetchAlbums();
      albumsResponse.fold(
        (failure) => emit(
          AlbumError(failure.errorMessage),
        ),
        (albums) => emit(
          AlbumLoaded(albums),
        ),
      );
    });
  }
}
