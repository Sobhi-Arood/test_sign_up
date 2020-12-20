import 'package:flutter/material.dart';

import 'customs.dart';

class TextFieldWidget extends StatefulWidget {
 
  final String title;
  final String validateMessage;
  final Function(String value) onSave;

  const TextFieldWidget({this.title, this.validateMessage, this.onSave});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _textController = TextEditingController();
  final int _fieldsLimit = 3;
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(boxShadow: [customBoxShadow]),
                child: TextFormField(
                  controller: _textController,
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: widget.title.toUpperCase(),
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      border: InputBorder.none),
                  validator: (value) =>
                      value.isEmpty ? widget.validateMessage : null,
                  onSaved: (value) => widget.onSave(value)
                ),
              ),
            );
  }
}