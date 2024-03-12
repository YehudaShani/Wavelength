import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class RadialSlider extends StatefulWidget {
  const RadialSlider({super.key, required this.onChange});
  final Function onChange;

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
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Center(child: slider),
          Positioned(
            bottom: 20,
            left: 60,
            child: Center(
              child: Text(
                'Minutes',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 80,
            child: Text(
              'Other',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
