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
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 206, 244, 255).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
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
