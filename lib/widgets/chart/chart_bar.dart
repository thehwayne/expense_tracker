import 'package:flutter/material.dart';

// This represents a single vertical bar in the expense chart
class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill; 

  @override
  Widget build(BuildContext context) {
    // Checks if we are currently in dark mode
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      // This allows the bar to evenly share space in a row
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          // This sets the height of the bar relative to the total available space
          heightFactor: fill,
          child: DecoratedBox(
            // The visual styling for the bar (rectangle, rounded top, color)
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
