
import 'package:flutter/material.dart';

import 'cubit/cubit.dart';

class AddingButtons extends StatelessWidget {
  const AddingButtons({
    Key? key,
    required this.cubit,
    required this.onPress,
    required this.text,
    required this.color,
  }) : super(key: key);

  final ProductAddingCubit cubit;
  final VoidCallback onPress;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
