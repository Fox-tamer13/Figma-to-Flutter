import 'package:flutter/foundation.dart';
import '../data/photo_repository.dart';
import '../models/photo.dart';

class PhotosViewModel extends ChangeNotifier {
  final PhotoRepository _repository = PhotoRepository();

  List<Photo> _photos = []; // Newest first
  bool _isLoading = false;
  String? _errorMessage;

  List<Photo> get photos => List.unmodifiable(_photos);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPhotos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _photos = await _repository.loadPhotos();
    } catch (error) {
      _errorMessage = 'Could not load your photos: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addPhoto(Uint8List bytes) async {
    try {
      final Photo photo = await _repository.savePhoto(bytes);
      _photos.insert(0, photo); // Newest goes first
      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }
}