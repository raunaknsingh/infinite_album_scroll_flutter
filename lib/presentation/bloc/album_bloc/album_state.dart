part of 'album_bloc.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  AlbumLoaded(this.albums);
}

class AlbumError extends AlbumState {
  final String message;
  AlbumError(this.message);
}
