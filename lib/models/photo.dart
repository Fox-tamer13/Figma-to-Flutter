import 'dart:typed_data';

class Photo {
  final DateTime takenAt;
  final Uint8List bytes;

  const Photo({
    required this.takenAt,
    required this.bytes,
  });

  @override
  String toString() => 'Photo taken $takenAt (${bytes.length} bytes)';
}