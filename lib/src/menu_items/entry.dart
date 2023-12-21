import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../_internals/brightness.dart';

/// Base class for entries in an iOS like menus.
@immutable
abstract interface class UIMenuEntry extends Widget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const UIMenuEntry({super.key});

  /// Returns an opacity level for disabled state of this [UIMenuEntry] for
  /// specific [Brightness].
  ///
  /// Opacity values were based on a direct pixel-to-pixel comparison with the
  /// native variant.
  @internal
  static double disabledOpacityOf(BuildContext context) =>
      switch (menuBrightnessOf(context)) {
        Brightness.dark => 0.55,
        Brightness.light => 0.45,
      };
}
