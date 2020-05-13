import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class StorageService {
  static StorageService shared = StorageService();
  StorageReference _storageReference = FirebaseStorage.instance.ref();

  Future<dynamic> filePicker() async {
    try {
      File file = await FilePicker.getFile(type: FileType.image);
      return file;
    } on PlatformException catch (e) {
      return e;
    }
  }

  Future<String> uploadFile(File file, String fileName) async {
    StorageReference imageReference =
        _storageReference.child('images/$fileName');
    StorageUploadTask uploadTask = imageReference.putFile(file);
    await uploadTask.onComplete;
    String url;
    await imageReference
        .getDownloadURL()
        .then((result) => url = result as String);
    print("URL $url");
    return url;
  }
}
