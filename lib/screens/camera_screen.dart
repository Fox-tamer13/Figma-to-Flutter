import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../view_models/photos_view_model.dart';
import '../widgets/widgets.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.photosViewModel});

  final PhotosViewModel photosViewModel;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  String? _problem;
  bool _isTakingPhoto = false;

  @override
  void initState() {
    super.initState();
    _startCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraException('noCamera', 'No camera found');
      }

      final CameraDescription camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();
    } on CameraException catch (error) {
      _problem = error.code.startsWith('CameraAccess')
          ? 'Camera permission was denied'
          : "Couldn't start the camera. Check that camera permission is allowed.";
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _takePhoto() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _isTakingPhoto = true);

    String message;
    try {
      final XFile file = await _controller!.takePicture();
      final Uint8List bytes = await file.readAsBytes();
      final bool saved = await widget.photosViewModel.addPhoto(bytes);
      message = saved ? 'Photo saved' : "Couldn't save the photo";
    } catch (error) {
      message = "Couldn't take the photo";
    }

    messenger.showSnackBar(SnackBar(content: Text(message)));
    if (mounted) {
      setState(() => _isTakingPhoto = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isReady = _controller?.value.isInitialized ?? false;

    return ListenableBuilder(
      listenable: widget.photosViewModel,
      builder: (context, child) {
        final int count = widget.photosViewModel.photos.length;

        return Scaffold(
          appBar: const AppHeader(title: 'Ghost Camera'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: isReady
                          ? CameraPreview(_controller!)
                          : _problem != null
                              ? Text(
                                  _problem!,
                                  style: textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                )
                              : const CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    count == 1 ? '1 photo saved' : '$count photos saved',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: isReady && !_isTakingPhoto ? _takePhoto : null,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take photo'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}