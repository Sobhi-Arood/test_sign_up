import 'dart:io';

import 'package:flutter/material.dart';

class AddImage extends ChangeNotifier {
  List<File> images = [];
  addImage(File img) async {
    images.add(img);
    notifyListeners();
  }
}