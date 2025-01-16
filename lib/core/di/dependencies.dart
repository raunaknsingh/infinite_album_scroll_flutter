import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:navatech_infinite_album_scroll/data/local/local_storage.dart';
import 'package:navatech_infinite_album_scroll/data/repository_impl/album_repository_impl.dart';
import 'package:navatech_infinite_album_scroll/data/repository_impl/photo_repository_impl.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/album_repository.dart';
import 'package:navatech_infinite_album_scroll/domain/repository/photo_repository.dart';
import 'package:navatech_infinite_album_scroll/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:navatech_infinite_album_scroll/presentation/bloc/photo_bloc/photo_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  //Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  //Connectivity
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  //Local Storage
  final localStorage = LocalStorage();
  await localStorage.init();
  getIt.registerSingleton<LocalStorage>(localStorage);

  //AlbumRepository
  getIt.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(
      dio: getIt(),
      connectivity: getIt(),
      localStorage: getIt(),
    ),
  );

  //PhotoRepository
  getIt.registerLazySingleton<PhotoRepository>(
        () => PhotoRepositoryImpl(
      dio: getIt(),
      connectivity: getIt(),
      localStorage: getIt(),
    ),
  );

  //AlbumBloc
  getIt.registerFactory(() => AlbumBloc(getIt()));

  //PhotoBloc
  getIt.registerFactory(() => PhotoBloc(getIt()));
}
