class AppSize {
  // full screen width and height

  static const double xdHeightSize = 667.0;
  static const double xdWidhtSize = 375.0;

  // static void setHeightSize(double size) {
  //   heightSize = size;
  //   heightPercentage = heightSize / xdHeightSize;
  // }

  static double widthProportions(double widthScreen, double size) {
    return widthScreen / xdWidhtSize;
  }

  static double heightProportions(double widthScreen, double size) {
    return widthScreen / xdWidhtSize;
  }
}

// double setWidth(double value) {
//   return value * AppSize.widthPercentage;
// }

// double setHeight(double value) {
//   return value * AppSize.heightPercentage;
// }
