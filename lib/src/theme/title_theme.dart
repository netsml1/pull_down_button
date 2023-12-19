import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '_dynamic_color.dart';
import '_fonts.dart';

// ignore_for_file: prefer_constructors_over_static_methods

/// Defines the visual properties of titles in iOS like menus.
///
/// Is used by [MenuTitle].
///
/// Typically a [MenuTitleTheme] is specified as part of the overall
/// [UIMenuTheme] with [UIMenuTheme.titleTheme].
///
/// All [MenuTitleTheme] properties are `null` by default. When null, defined
/// earlier use cases will use the values from [UIMenuTheme] if they exist,
/// otherwise it will use iOS 17 defaults specified in
/// [MenuTitleTheme.defaults].
@immutable
final class MenuTitleTheme with Diagnosticable {
  /// Creates the set of properties used to configure [MenuTitleTheme].
  const MenuTitleTheme({
    this.textStyle,
  });

  /// Creates default set of properties used to configure [MenuTitleTheme].
  ///
  /// Default properties were taken from the Apple Design Resources Sketch file.
  ///
  /// See also:
  ///
  /// * Apple Design Resources Sketch file:
  /// <https://developer.apple.com/design/resources/>
  @internal
  const factory MenuTitleTheme.defaults(BuildContext context) = _Defaults;

  /// The text style of title in menu.
  final TextStyle? textStyle;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  MenuTitleTheme copyWith({
    TextStyle? textStyle,
  }) =>
      MenuTitleTheme(
        textStyle: textStyle ?? this.textStyle,
      );

  /// Linearly interpolate between two menu title themes.
  static MenuTitleTheme lerp(
    MenuTitleTheme? a,
    MenuTitleTheme? b,
    double t,
  ) {
    if (identical(a, b) && a != null) return a;

    return MenuTitleTheme(
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }

  @override
  int get hashCode => textStyle.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! MenuTitleTheme) return false;

    return other.textStyle == textStyle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty('textStyle', textStyle, defaultValue: null),
    );
  }
}

/// A set of default values for [MenuTitleTheme].
// TODO(notDmDrl): Recheck values with a new iOS 17 sketch file.
@immutable
final class _Defaults extends MenuTitleTheme {
  /// Creates [_Defaults].
  const _Defaults(this.context);

  /// A build context used to resolve [SimpleDynamicColor]s defined in this
  /// theme.
  final BuildContext context;

  /// The light and dark colors of [MenuTitle.title].
  static const kTitleColor = SimpleDynamicColor(
    color: Color.fromRGBO(60, 60, 67, 0.6),
    darkColor: Color.fromRGBO(235, 235, 245, 0.6),
  );

  /// The text style of [MenuTitle.title].
  static const kStyle = TextStyle(
    inherit: false,
    fontFamily: kFontFamily,
    fontFamilyFallback: kFontFallbacks,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
  );

  @override
  TextStyle? get textStyle => kStyle.copyWith(
        color: kTitleColor.resolveFrom(context),
      );
}
