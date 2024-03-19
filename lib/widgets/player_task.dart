import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerTask extends StatelessWidget {
  const PlayerTask({super.key, required this.isGuesser});
  final bool isGuesser;

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
      height: 130,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: null,
            right: null,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "You are...",
                style: GoogleFonts.amaticSc(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (isGuesser)
            const Text(
              'Waiting for your turn',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  isGuesser ? 'Guessing!' : 'Hinting!',
                  style: GoogleFonts.kavivanar(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: isGuesser ? Colors.green : Colors.red[400],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
