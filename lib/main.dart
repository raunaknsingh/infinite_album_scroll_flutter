import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_infinite_album_scroll/data/local/local_storage.dart';
import 'package:navatech_infinite_album_scroll/data/repository_impl/album_repository_impl.dart';
import 'package:navatech_infinite_album_scroll/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:navatech_infinite_album_scroll/presentation/pages/albums_home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = LocalStorage();
  await localStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AlbumBloc(
            AlbumRepositoryImpl(
              dio: Dio(),
              connectivity: Connectivity(),
              localStorage: LocalStorage()
            ),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Infinite Album and Photo Scroll',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AlbumsHomePage(),
      ),
    );
  }
}
