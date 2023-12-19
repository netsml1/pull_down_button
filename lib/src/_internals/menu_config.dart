import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../menu_items/entry.dart';
import 'content_size_category.dart';

enum _MenuConfigAspect {
  hasLeading,
  hasTrailing,
  theme,
  contentSize,
}

/// An inherited widget used to provide menu configuration to all its descendant
/// widgets.
@immutable
@internal
final class MenuConfig extends InheritedModel<_MenuConfigAspect> {
  /// Creates [MenuConfig].
  const MenuConfig({
    super.key,
    required super.child,
    required this.hasLeading,
    required this.hasTrailing,
    required this.ambientTheme,
    required this.contentSizeCategory,
  });

  /// Whether the menu has any [UIMenuEntry] widgets with leading widget such
  /// as a checkmark.
  final bool hasLeading;

  /// Whether the menu has any [UIMenuEntry] widgets with trailing widget such
  /// as a chevron.
  final bool hasTrailing;

  /// An ambient [UIMenuTheme] returned by [UIMenuTheme.ambientOf].
  final UIMenuTheme ambientTheme;

  /// Current text scale level.
  final ContentSizeCategory contentSizeCategory;

  static MenuConfig _of(BuildContext context, _MenuConfigAspect aspect) =>
      InheritedModel.inheritFrom<MenuConfig>(context, aspect: aspect)!;

  /// Returns a [bool] value indicating whether menu has any [UIMenuEntry]s with
  /// leading widget from the closest [MenuConfig] ancestor.
  static bool hasLeadingOf(BuildContext context) =>
      _of(context, _MenuConfigAspect.hasLeading).hasLeading;

  /// Returns a [bool] value indicating whether menu has any [UIMenuEntry]s with
  /// trailing widget from the closest [MenuConfig] ancestor.
  static bool hasTrailingOf(BuildContext context) =>
      _of(context, _MenuConfigAspect.hasTrailing).hasTrailing;

  /// Returns a [UIMenuTheme] value from the closest [MenuConfig] ancestor.
  static UIMenuTheme ambientThemeOf(BuildContext context) =>
      _of(context, _MenuConfigAspect.theme).ambientTheme;

  /// Returns a [ContentSizeCategory] value from the closest [MenuConfig]
  /// ancestor.
  static ContentSizeCategory contentSizeCategoryOf(BuildContext context) =>
      _of(context, _MenuConfigAspect.contentSize).contentSizeCategory;

  @override
  bool updateShouldNotify(MenuConfig oldWidget) =>
      hasLeading != oldWidget.hasLeading ||
      hasTrailing != oldWidget.hasTrailing ||
      ambientTheme != oldWidget.ambientTheme ||
      contentSizeCategory != oldWidget.contentSizeCategory;

  @override
  bool updateShouldNotifyDependent(
    MenuConfig oldWidget,
    Set<Object> dependencies,
  ) {
    for (final dependency in dependencies) {
      if (dependency is _MenuConfigAspect) {
        return switch (dependency) {
          _MenuConfigAspect.hasLeading => hasLeading != oldWidget.hasLeading,
          _MenuConfigAspect.hasTrailing => hasTrailing != oldWidget.hasTrailing,
          _MenuConfigAspect.theme => ambientTheme != oldWidget.ambientTheme,
          _MenuConfigAspect.contentSize =>
            contentSizeCategory != oldWidget.contentSizeCategory,
        };
      }
    }

    return false;
  }
}
