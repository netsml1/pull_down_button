import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../menu_items/entry.dart';

/// A [Brightness] which a UIMenu should use for its looks.
@internal
Brightness menuBrightnessOf(BuildContext context) =>
    CupertinoTheme.maybeBrightnessOf(context) ?? Theme.of(context).brightness;

/// Returns an opacity level for disabled state of this [UIMenuEntry] for
/// specific [Brightness].
///
/// Opacity values were based on a direct pixel-to-pixel comparison with the
/// native variant.
@internal
double disabledOpacityOf(BuildContext context) =>
    switch (menuBrightnessOf(context)) {
      Brightness.dark => 0.55,
      Brightness.light => 0.45,
    };
