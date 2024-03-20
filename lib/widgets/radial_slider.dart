import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RadialSlider extends StatefulWidget {
  const RadialSlider(
      {super.key,
      required this.onChange,
      required this.bottomLabel,
      required this.topLabel,
      this.initialValue = 50,
      this.isGuessing = true});
  final Function onChange;
  final String bottomLabel;
  final String topLabel;
  final int initialValue;
  final bool isGuessing;

  @override
  State<RadialSlider> createState() => _RadialSliderState();
}

class _RadialSliderState extends State<RadialSlider> {
  @override
  Widget build(BuildContext context) {
    final progressBarColors = !widget.isGuessing
        ? [
            Color.fromARGB(255, 222, 49, 37),
            Color.fromARGB(255, 193, 129, 124),
          ]
        : [
            Color.fromARGB(255, 37, 222, 37),
            Color.fromARGB(255, 124, 193, 124)
          ];

    final slider = SleekCircularSlider(
      initialValue: widget.initialValue.toDouble(),
      appearance: CircularSliderAppearance(
        infoProperties: InfoProperties(
          mainLabelStyle: GoogleFonts.originalSurfer(
            fontSize: 40,
          ),
          modifier: (double value) {
            final roundedValue = value.toInt().toString();
            return roundedValue;
          },
        ),
        size: 300,
        customWidths: CustomSliderWidths(progressBarWidth: 20),
        customColors: CustomSliderColors(
          progressBarColors: progressBarColors,
          trackColor: Theme.of(context).colorScheme.secondary,
        ),
        // animationEnabled: false,
      ),
      onChange: (double value) {
        widget.onChange(value.toInt());
      },
    );
    return Stack(
      children: [
        Center(child: slider),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 20),
                Text(
                  widget.bottomLabel,
                  style: GoogleFonts.originalSurfer(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 30),
                Text(
                  widget.topLabel,
                  style: GoogleFonts.originalSurfer(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
