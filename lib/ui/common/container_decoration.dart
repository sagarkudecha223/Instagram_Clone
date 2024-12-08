import 'package:flutter/material.dart';

import '../../core/colors.dart';

class ContainerLinearGradient extends LinearGradient {
  const ContainerLinearGradient({
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    List<Color>? backgroundColor,
  }) : super(
          begin: begin ?? Alignment.topLeft,
          end: end ?? Alignment.bottomRight,
          colors: backgroundColor ?? AppColors.screenBackgroundGradientColor,
        );
}
