import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String category;
  final String subCategory;

  const QuestionWidget(
      {Key? key, required this.category, required this.subCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          ('The scale in use is $subCategory!'),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
