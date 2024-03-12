import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RadialSlider extends StatefulWidget {
  const RadialSlider(
      {super.key,
      required this.onChange,
      required this.bottomLabel,
      required this.topLabel});
  final Function onChange;
  final String bottomLabel;
  final String topLabel;

  @override
  State<RadialSlider> createState() => _RadialSliderState();
}

class _RadialSliderState extends State<RadialSlider> {
  @override
  Widget build(BuildContext context) {
    final slider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 36,
          ),
          modifier: (double value) {
            final roundedValue = value.toInt().toString();
            return '$roundedValue';
          },
        ),
        size: 300,
        customWidths: CustomSliderWidths(progressBarWidth: 20),
        customColors: CustomSliderColors(
          progressBarColors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ],
          trackColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      onChange: (double value) {
        widget.onChange(value.toInt());
      },
    );
    return Stack(
      children: [
        Center(child: slider),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.bottomLabel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                ),
              ),
              Text(
                widget.topLabel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
