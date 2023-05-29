import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final int nroAlbum;
  final double currentPage;

  const AlbumCard({
    super.key,
    required this.nroAlbum,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    double relativePosition = nroAlbum - currentPage;

    return SizedBox(
      width: 250.0,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..scale((1 - relativePosition.abs()).clamp(0.2, 0.6) + 0.4)
          ..rotateY(relativePosition),
        alignment: relativePosition >= 0
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            image: DecorationImage(
              image: AssetImage('assets/${nroAlbum + 1}.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
