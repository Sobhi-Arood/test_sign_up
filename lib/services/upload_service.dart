import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UploadService {
  static UploadService instance = UploadService();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    try {
      final String filePath = 'avatar/${DateTime.now()}.png';
      final Reference storageReference = _storage.ref().child(filePath);
      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      final url = await storageReference.getDownloadURL();
      return url;
    } catch (e) {
      return 'Error uploading';   
    }
  }
}