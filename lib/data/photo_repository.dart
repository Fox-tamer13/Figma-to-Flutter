import 'dart:typed_data';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import '../models/photo.dart';

class PhotoRepository {
  static const String _boxName = 'ghost_photos';

  Box<Uint8List>? _box;

  Future<Box<Uint8List>> _openBox() async {
    if (_box == null) {
      await Hive.initFlutter();
      _box = await Hive.openBox<Uint8List>(_boxName);
    }
    return _box!;
  }

  Future<List<Photo>> loadPhotos() async {
    final Box<Uint8List> box = await _openBox();

    final List<Photo> photos = box.keys.map((key) {
      return Photo(
        takenAt: DateTime.fromMillisecondsSinceEpoch(int.parse(key as String)),
        bytes: box.get(key)!,
      );
    }).toList();

    photos.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    return photos;
  }

  Future<Photo> savePhoto(Uint8List bytes) async {
    final Box<Uint8List> box = await _openBox();
    final DateTime now = DateTime.now();

    await box.put(now.millisecondsSinceEpoch.toString(), bytes);
    return Photo(takenAt: now, bytes: bytes);
  }
}