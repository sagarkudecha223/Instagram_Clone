class TransitionDuration {
  static const Duration immediate = Duration();
  static const Duration fast = Duration(milliseconds: 100);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 700);
  static const Duration verySlow = Duration(milliseconds: 1000);
  static const Duration superSlow = Duration(milliseconds: 3000);
  static const Duration ultimateSlow = Duration(milliseconds: 5000);
  static const Duration deBounceTimer = Duration(milliseconds: 300);
}
