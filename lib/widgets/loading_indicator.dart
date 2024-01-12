import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
