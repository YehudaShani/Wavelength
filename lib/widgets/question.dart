import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: GoogleFonts.pressStart2p().fontFamily,
              ),
        ),
        Text(
          ('The scale in use is $subCategory!'),
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
