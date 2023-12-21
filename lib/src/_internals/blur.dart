import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'brightness.dart';

/// A set of blur utils.
///
/// All of the values were eyeballed using the iOS 16 Simulator.
@internal
abstract final class UIMenuBlur {
  /// Check if the menu's background color is not fully opaque.
  ///
  /// Returns false if [color] has no transparency. If so, [BackdropFilter] will
  /// not be used since it will be redundant. Also, in some cases, this might
  /// help with performance or visual bugs.
  static bool useBackdropFilter(Color color) => color.alpha != 0xFF;

  /// Menu background blur.
  ///
  /// See also:
  ///
  /// * Apple Design Resources Sketch file:
  /// <https://developer.apple.com/design/resources>.
  static const double _kBlurSigma = 50;

  // Blur saturation for light and dark theme brightnesses.
  // 1 means 0% in Sketch.
  static const double _kLightSaturation = 1.21;
  static const double _kDarkSaturation = 1.9;

  /// Blur used by [ui.ImageFilter.compose] as an inner filter.
  static final _menuBlur = ui.ImageFilter.blur(
    sigmaX: _kBlurSigma,
    sigmaY: _kBlurSigma,
  );

  /// Blur used by [BackdropFilter] if [UIMenuBlur.useBackdropFilter] is `true`.
  static ui.ImageFilter menuBlur(BuildContext context) {
    final saturation = switch (menuBrightnessOf(context)) {
      Brightness.dark => _kDarkSaturation,
      Brightness.light => _kLightSaturation,
    };

    return ui.ImageFilter.compose(
      outer: ui.ColorFilter.matrix(
        _matrixWithSaturation(saturation),
      ),
      inner: _menuBlur,
    );
  }
}

// Taken from [CupertinoDesktopTextSelectionToolbar] private static method.
/// Creates a 5x5 matrix that increases saturation when used with
/// [ui.ColorFilter.matrix].
///
/// The numbers were taken from this comment:
/// [Cupertino blurs should boost saturation](https://github.com/flutter/flutter/issues/29483#issuecomment-477334981).
List<double> _matrixWithSaturation(double saturation) {
  final r = 0.213 * (1 - saturation);
  final g = 0.715 * (1 - saturation);
  final b = 0.072 * (1 - saturation);

  return [
    r + saturation, g, b, 0, 0, //
    r, g + saturation, b, 0, 0, //
    r, g, b + saturation, 0, 0, //
    0, 0, 0, 1, 0, //
  ];
}
