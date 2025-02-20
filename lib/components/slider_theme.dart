import 'package:flutter/material.dart';
import 'package:graphical_model_interface/theme.dart';

class Slider3D extends StatefulWidget {
  final double min;
  final double max;
  final double sliderValue;
  final bool isInt;
  final double? label;
  final Function(double) onChanged;
  const Slider3D({
    super.key,
    required this.sliderValue,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.isInt,
    this.label,
  });

  @override
  State<Slider3D> createState() => _Slider3DState();
}

class _Slider3DState extends State<Slider3D> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        // Remove extra overlay/padding by making overlay size zero
        // overlayShape: SliderComponentShape.noOverlay,
        trackHeight: 4,
        thumbShape: CustomSliderThumbShape(
          value: widget.sliderValue,
          isInt: widget.isInt,
          label: widget.label,
        ),
        // You can also adjust trackShape if needed.
        // For no extra horizontal padding, you might create a custom TrackShape.
        // For now, you can set trackShape to the default.
      ),
      child: Slider(
          min: widget.min,
          max: widget.max,
          value: (widget.isInt) ? widget.sliderValue : widget.sliderValue,
          activeColor: Colors.grey.shade800,
          onChanged: (value) {
            widget.onChanged(value);
          }),
    );
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final bool isInt;
  final double value;
  final double? label;

  const CustomSliderThumbShape({
    this.thumbRadius = 10,
    required this.value,
    required this.isInt,
    this.label,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(thumbRadius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    TextPainter? labelPainter, // Not used here
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value, // Ranges from 0.0 to 1.0
    required double textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Create a path for the thumb.
    final Path thumbPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: thumbRadius));

    // Draw shadow for the thumb.
    canvas.drawShadow(thumbPath, Colors.black.withOpacity(0.9), 8.0, false);

    // Define a gradient shader from light blue to dark blue
    final Rect thumbRect = Rect.fromCircle(center: center, radius: thumbRadius);
    final Paint fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Col.blue, Col.darkBlue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(thumbRect)
      ..style = PaintingStyle.fill;

    // White stroke paint
    final Paint strokePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint); // drawing the circle
    canvas.drawCircle(
        center, thumbRadius, strokePaint); // drawing the white border

    // Format the value: if it's an integer, show without decimals.
    double labelText = label ?? this.value;
    final String valueText =
        (isInt) ? labelText.toInt().toString() : labelText.toString();

    // Draw the value text below the thumb.
    final TextSpan span = TextSpan(
      text: valueText,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    // Position the text so that it is centered horizontally beneath the thumb
    final Offset textOffset =
        Offset(center.dx - tp.width / 2, center.dy + thumbRadius + 4);
    tp.paint(canvas, textOffset);
  }
}
