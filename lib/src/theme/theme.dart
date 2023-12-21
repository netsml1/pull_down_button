import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../menu_items/entry.dart';
import 'divider_theme.dart';
import 'title_theme.dart';

T? _lerpType<T>(T? a, T? b, double t) => t < 0.5 ? a : b;

/// Defines the visual properties of iOS like menus as well as any widgets that
/// extend [UIMenuEntry].
///
/// [UIMenuTheme] should be specified in [ThemeData.extensions] or using
/// [UIMenuInheritedTheme] in the `builder` property of [MaterialApp] or
/// [CupertinoApp].
///
/// All [UIMenuTheme] properties are `null` by default. When null, or some
/// properties of sub-themes are null, iOS 17 defaults specified in each
/// sub-theme will be used.
///
/// See also:
///
/// * [MenuDividerTheme], a sub-theme for the dividers and separators in menus.
/// * [MenuTitleTheme], a sub-theme for [MenuTitle].
/// * [UIMenuInheritedTheme], an alternative way of defining ambient
/// [UIMenuTheme].
@immutable
final class UIMenuTheme extends ThemeExtension<UIMenuTheme>
    with Diagnosticable {
  /// Create a [UIMenuTheme] by providing various common properties between
  /// sub-themes.
  ///
  /// For more control over [UIMenuTheme] configuration consider using
  /// [UIMenuTheme.raw].
  factory UIMenuTheme({
    String? fontFamily,
    Color? backgroundColor,
    Color? onBackgroundColor,
    Color? onBackgroundColorVariant,
    Color? dividerColor,
    Color? separatorColor,
    Color? destructiveColor,
  }) {
    final dividerTheme = MenuDividerTheme(
      dividerColor: dividerColor,
      separatorColor: separatorColor,
    );

    final titleTheme = MenuTitleTheme(
      textStyle: TextStyle(
        fontFamily: fontFamily,
        color: onBackgroundColorVariant,
      ),
    );

    return UIMenuTheme.raw(
      dividerTheme: dividerTheme,
      titleTheme: titleTheme,
    );
  }

  /// Creates the set of properties used to configure [UIMenuTheme] by providing
  /// sub-themes separately.
  const UIMenuTheme.raw({
    this.dividerTheme,
    this.titleTheme,
  });

  /// Sub-theme for visual properties of the dividers and separators in menus.
  final MenuDividerTheme? dividerTheme;

  /// Sub-theme for visual properties of the titles in menus.
  final MenuTitleTheme? titleTheme;

  /// Returns the current ambient [UIMenuTheme].
  ///
  /// At first tries to get [UIMenuTheme] from [UIMenuInheritedTheme]. If that's
  /// null, gets [UIMenuTheme] from the ambient [Theme] extensions.
  static UIMenuTheme? maybeOf(BuildContext context) =>
      UIMenuInheritedTheme.maybeOf(context) ??
      Theme.of(context).extension<UIMenuTheme>();

  // TODO(notDmDrl): todo.
  static UIMenuTheme ambientOf(BuildContext context) {}

  @override
  ThemeExtension<UIMenuTheme> copyWith({
    MenuDividerTheme? dividerTheme,
    MenuTitleTheme? titleTheme,
  }) =>
      UIMenuTheme.raw(
        dividerTheme: dividerTheme ?? this.dividerTheme,
        titleTheme: titleTheme ?? this.titleTheme,
      );

  @override
  ThemeExtension<UIMenuTheme> lerp(
    ThemeExtension<UIMenuTheme>? other,
    double t,
  ) {
    if (other is! UIMenuTheme || identical(this, other)) return this;

    return UIMenuTheme.raw(
      dividerTheme: MenuDividerTheme.lerp(dividerTheme, other.dividerTheme, t),
      titleTheme: MenuTitleTheme.lerp(titleTheme, other.titleTheme, t),
    );
  }

  @override
  int get hashCode => Object.hash(dividerTheme, titleTheme);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! UIMenuTheme) return false;

    return other.dividerTheme == dividerTheme && other.titleTheme == titleTheme;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    [
      DiagnosticsProperty('dividerTheme', dividerTheme, defaultValue: null),
      DiagnosticsProperty('titleTheme', titleTheme, defaultValue: null),
    ].map(properties.add);
  }
}

/// An alternative way of defining global [UIMenuTheme].
///
/// Useful for the cases when defining [UIMenuTheme] inside of
/// [ThemeData.extensions] is not possible (for example while using
/// [CupertinoApp]).
///
/// Example:
///
/// ```dart
/// CupertinoApp(
///   builder: (context, child) => UIMenuInheritedTheme(
///     data: UIMenuTheme(...),
///     child: child!,
///   ),
///   home: ...,
/// )
/// ```
@immutable
class UIMenuInheritedTheme extends InheritedTheme {
  /// Creates a [UIMenuInheritedTheme].
  const UIMenuInheritedTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration of this theme.
  final UIMenuTheme data;

  /// Returns the current [UIMenuTheme] from the closest [UIMenuInheritedTheme]
  /// ancestor.
  ///
  /// If there is no ancestor, it returns `null`.
  static UIMenuTheme? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UIMenuInheritedTheme>()?.data;

  @override
  bool updateShouldNotify(UIMenuInheritedTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) => UIMenuInheritedTheme(
        data: data,
        child: child,
      );
}
