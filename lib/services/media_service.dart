import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService instance = MediaService();

  Future<PickedFile> getImageFromLibrary() {
    return ImagePicker().getImage(source: ImageSource.gallery);
  }
}
