import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_infinite_album_scroll/core/di/dependencies.dart';
import 'package:navatech_infinite_album_scroll/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:navatech_infinite_album_scroll/presentation/bloc/photo_bloc/photo_bloc.dart';

import '../widgets/album_card.dart';

class AlbumsHomePage extends StatelessWidget {
  const AlbumsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AlbumBloc>().add(FetchAlbums());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll Album'),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, albumState) {
        if (albumState is AlbumLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (albumState is AlbumLoaded) {
          final albums = albumState.albums;
          if (albums.isEmpty) {
            return const Center(
              child: Text(
                'No albums present',
              ),
            );
          }
          return ListView.builder(
              itemCount: double.maxFinite.toInt(),
              itemBuilder: (context, index) {
                final album = albums[index % albums.length];
                return BlocProvider(
                  create: (_) => getIt<PhotoBloc>()..add(FetchPhotos(album.id)),
                  child: AlbumCard(
                    album: album,
                  ),
                );
              });
        } else if (albumState is AlbumError) {
          return Center(
            child: Text(
              'Album loading error: ${albumState.message}',
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
