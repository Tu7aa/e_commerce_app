import 'package:flutter/material.dart';

class ScaffoldGlobalWidget extends StatelessWidget {
  final String titleText;
  final Widget? leadingIcon;
  final Widget body;

  const ScaffoldGlobalWidget({
    Key? key,
    required this.titleText,
    this.leadingIcon,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: leadingIcon ?? Icon(Icons.arrow_back)),
      ),
      body: body,
    );
  }
}
