import 'package:flutter/material.dart';
import 'package:navatech_infinite_album_scroll/domain/entity/photo.dart';

class InfiniteHorizontalPhotosList extends StatelessWidget {
  final List<Photo> photos;

  const InfiniteHorizontalPhotosList({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Image.asset(
            'assets/images/no_image.jpg',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: double.maxFinite.toInt(),
          itemBuilder: (context, index) {
            final photo = photos[index % photos.length];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Image.network(
                    photo.url,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    photo.title.length > 10
                        ? '${photo.title.substring(0, 10)}...'
                        : photo.title,
                    style: const TextStyle(fontSize: 12.0),
                  )
                ],
              ),
            );
          }),
    );
  }
}
