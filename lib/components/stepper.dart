import 'package:flutter/material.dart';

class Stepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final VoidCallback incrementStep;
  final VoidCallback decrementStep;

  const Stepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.incrementStep,
    required this.decrementStep,
  });

  Color _stepColor(int index) {
    if (index < currentStep) {
      return Colors.green.shade700; // Completed steps
    } else if (index == currentStep) {
      return Colors.blue.shade800; // Current step
    } else {
      return Colors.white; // Upcoming steps
    }
  }

  @override
  Widget build(BuildContext context) {
    bool largeWidth = MediaQuery.of(context).size.width > 120 * totalSteps;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
            opacity: (currentStep > 1) ? 1 : 0,
            child: TextButton(
                onPressed: (currentStep > 1) ? decrementStep : null,
                child: const Text("Previous"))),
        const SizedBox(width: 16),
        Column(
          children: [
            (largeWidth)
                ? const SizedBox()
                : Text((totalSteps < currentStep)
                    ? "Complete"
                    : "Step $currentStep of $totalSteps"),
            if (!largeWidth) const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalSteps, (index) {
                return Row(
                  children: [
                    (largeWidth)
                        ? step(index + 1, _stepColor(index + 1))
                        : const SizedBox(),
                    if (index < totalSteps - 1)
                      Container(
                        width: 30,
                        height: 5,
                        color: (index + 1 < currentStep)
                            ? Colors.green.shade700
                            : Colors.white,
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
        const SizedBox(width: 16),
        TextButton(onPressed: incrementStep, child: const Text("Next")),
      ],
    );
  }

  Container step(int index, Color color) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(150),
      ),
      child: Center(
          child: Text(
        "$index",
        style: TextStyle(
          color: (color == Colors.white) ? Colors.black : Colors.white,
        ),
      )),
    );
  }
}
