import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test_sign_up/misc/image_file.dart';

class ImagePickerButton extends StatefulWidget {
  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await Provider.of<AddImage>(context, listen: false).addImage(File(pickedFile.path));
      setState(() {
      
        _image = File(pickedFile.path);
    });
    } else {
        print('No image selected.');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: _image == null
            ? RaisedButton(child: Text('Select an image'), onPressed: () => getImage(),)
            : Image.file(_image),
      ),
    );
  }
}