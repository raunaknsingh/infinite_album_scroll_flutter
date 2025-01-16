import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_infinite_album_scroll/presentation/bloc/album_bloc/album_bloc.dart';

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
            return const Text(
              'No albums present',
            );
          }
          return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Item$index'),
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
