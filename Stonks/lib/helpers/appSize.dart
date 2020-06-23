class AppSize {
  // full screen width and height

  static const double xdHeightSize = 667.0;
  static const double xdWidhtSize = 375.0;

  static double widthProportions(double value) {
    return value / xdWidhtSize;
  }

  static double heightProportions(double value) {
    return value / xdHeightSize;
  }
}
