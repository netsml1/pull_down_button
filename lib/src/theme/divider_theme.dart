import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../menu_items/divider.dart';
import '_dynamic_color.dart';

// ignore_for_file: prefer_constructors_over_static_methods

/// Defines the visual properties of the dividers and separators in iOS like
/// menus.
///
/// Is used by [MenuDivider], horizontal and vertical separators in menus.
///
/// Typically a [MenuDividerTheme] is specified as part of the overall
/// [UIMenuTheme] with [UIMenuTheme.dividerTheme].
///
/// All [MenuDividerTheme] properties are `null` by default. When null, defined
/// earlier use cases will use the values from [UIMenuTheme] if they exist,
/// otherwise it will use iOS 17 defaults specified in
/// [MenuDividerTheme.defaults].
@immutable
final class MenuDividerTheme with Diagnosticable {
  /// Creates the set of properties used to configure [MenuDividerTheme].
  const MenuDividerTheme({
    this.dividerColor,
    this.separatorColor,
  });

  /// Creates default set of properties used to configure [MenuDividerTheme].
  ///
  /// Default properties were taken from the Apple Design Resources Sketch file.
  ///
  /// See also:
  ///
  /// * Apple Design Resources Sketch file:
  /// <https://developer.apple.com/design/resources/>
  @internal
  const factory MenuDividerTheme.defaults(BuildContext context) = _Defaults;

  /// The color of the [MenuDivider].
  final Color? dividerColor;

  /// The color of the horizontal and vertical separators.
  final Color? separatorColor;

  /// Creates a copy of this object with the given fields replaced with the
  /// new values.
  MenuDividerTheme copyWith({
    Color? dividerColor,
    Color? separatorColor,
  }) =>
      MenuDividerTheme(
        dividerColor: dividerColor ?? this.dividerColor,
        separatorColor: separatorColor ?? this.separatorColor,
      );

  /// Linearly interpolate between two menu divider themes.
  static MenuDividerTheme lerp(
    MenuDividerTheme? a,
    MenuDividerTheme? b,
    double t,
  ) {
    if (identical(a, b) && a != null) return a;

    return MenuDividerTheme(
      dividerColor: Color.lerp(a?.dividerColor, b?.dividerColor, t),
      separatorColor: Color.lerp(a?.separatorColor, b?.separatorColor, t),
    );
  }

  @override
  int get hashCode => Object.hash(dividerColor, separatorColor);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! MenuDividerTheme) return false;

    return other.dividerColor == dividerColor &&
        other.separatorColor == separatorColor;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    [
      ColorProperty('dividerColor', dividerColor, defaultValue: null),
      ColorProperty('separatorColor', separatorColor, defaultValue: null),
    ].map(properties.add);
  }
}

/// A set of default values for [MenuDividerTheme].
// TODO(notDmDrl): Recheck values with a new iOS 17 sketch file.
@immutable
final class _Defaults extends MenuDividerTheme {
  /// Creates [_Defaults].
  const _Defaults(this.context);

  /// A build context used to resolve [SimpleDynamicColor]s defined in this
  /// theme.
  final BuildContext context;

  /// The light and dark colors of the [MenuDivider].
  static const kDividerColor = SimpleDynamicColor(
    color: Color.fromRGBO(17, 17, 17, 0.3),
    darkColor: Color.fromRGBO(217, 217, 217, 0.3),
  );

  /// The light and dark colors of the horizontal and vertical separators.
  static const kSeparatorColor = SimpleDynamicColor(
    color: Color.fromRGBO(0, 0, 0, 0.08),
    darkColor: Color.fromRGBO(0, 0, 0, 0.16),
  );

  @override
  Color get dividerColor => kDividerColor.resolveFrom(context);

  @override
  Color get separatorColor => kSeparatorColor.resolveFrom(context);
}
