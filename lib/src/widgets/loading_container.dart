import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      title: Container(
        height: 40,
        width: size.width * .8,
        color: Colors.grey.shade400,
      ),
      subtitle: Container(
        height: 24,
        margin: EdgeInsets.only(top: 4),
        width: size.width * .8,
        color: Colors.grey.shade400,
      ),
    );
  }
}
