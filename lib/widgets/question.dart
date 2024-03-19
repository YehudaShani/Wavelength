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
    return Container(
      height: 100,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text("The category is:",
                  style: GoogleFonts.originalSurfer(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: FittedBox(
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.originalSurfer(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
