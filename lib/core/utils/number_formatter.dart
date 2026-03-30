class NumberFormatter {
  const NumberFormatter();

  String formatDouble(double value) {
    if (!value.isFinite) {
      return 'Error';
    }

    // Avoid negative zero.
    if (value == 0) {
      return '0';
    }

    // Use precision to keep results readable for interview/demo purposes.
    final s = value.toStringAsPrecision(12);

    // Trim trailing zeros in decimals (e.g., 2.50000 -> 2.5).
    if (s.contains('.')) {
      return s
          .replaceAll(RegExp(r'0+$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    }
    return s;
  }
}

