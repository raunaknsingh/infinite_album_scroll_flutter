import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/album.dart';
import '../bloc/photo_bloc/photo_bloc.dart';
import 'infinite_horizontal_photos_list.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  const AlbumCard({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              album.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            BlocBuilder<PhotoBloc, PhotoState>(builder: (context, photoState) {
              if (photoState is PhotoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (photoState is PhotoLoaded) {
                return InfiniteHorizontalPhotosList(photos: photoState.photos);
              } else if (photoState is PhotoError) {
                return Text('Photo loading error: ${photoState.message}');
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
