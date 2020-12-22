import 'package:flutter/material.dart';

import 'customs.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final String validateMessage;
  final Function(String value) onSave;
  final TextInputType keyboardType;

  const TextFieldWidget(
      {this.title, this.validateMessage, this.onSave, this.keyboardType});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _textController,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.title.toUpperCase(),
            hintStyle: Theme.of(context).textTheme.bodyText2,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            border: InputBorder.none),
        validator: (value) => value.isEmpty ? widget.validateMessage : null,
        onSaved: (value) => widget.onSave(value));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
