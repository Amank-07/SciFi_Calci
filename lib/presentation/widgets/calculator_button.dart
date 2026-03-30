import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final double fontSize;
  final bool isDense;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    this.fontSize = 18,
    this.isDense = false,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _highlighted = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(18);
    final scale = _highlighted ? 0.97 : 1.0;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: widget.onTap,
          onHighlightChanged: (v) => setState(() => _highlighted = v),
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: borderRadius,
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
              boxShadow: widget.isDense
                  ? []
                  : [
                      BoxShadow(
                        color: widget.backgroundColor.withOpacity(0.28),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: widget.isDense
                  ? const EdgeInsets.symmetric(horizontal: 8, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.foregroundColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

