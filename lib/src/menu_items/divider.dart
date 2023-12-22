// The values were taken from the Apple Design Resources Sketch file.
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../_internals/menu_config.dart';
import '../theme/divider_theme.dart';
import 'entry.dart';

const double _kDividerHeight = 8;
const double _kSeparatorHeight = 0;

/// A horizontal divider for iOS like menus.
///
/// Divider is always 8px in height.
@immutable
class MenuDivider extends StatelessWidget implements UIMenuEntry {
  /// Creates a horizontal divider for a menu.
  const MenuDivider({
    super.key,
    this.color,
  });

  /// The color of the divider.
  ///
  /// If this property is null, then the value from the ambient
  /// [MenuDividerTheme] is used.
  final Color? color;

  @override
  Widget build(BuildContext context) => Divider(
        height: _kDividerHeight,
        thickness: _kDividerHeight,
        color: color ??
            MenuConfig.ambientThemeOf(context).dividerTheme!.dividerColor,
      );
}

/// A separator for iOS like menus.
///
/// For usage in horizontal cases, separator is always 0px in height. For usage
/// in vertical cases, separator is always 0px in width.
@immutable
@internal
class MenuSeparator extends StatelessWidget implements UIMenuEntry {
  /// Creates a separator for a menu.
  const MenuSeparator._({required this.axis});

  /// The direction along which the separator is rendered.
  final Axis axis;

  /// Helper method that simplifies separation of items in iOS like menus.
  static List<UIMenuEntry> wrapList(List<UIMenuEntry> items) {
    if (items.isEmpty) return const [];
    if (items.length == 1) return items;

    const divider = MenuSeparator._(axis: Axis.horizontal);

    final list = <UIMenuEntry>[];

    for (var i = 0; i < items.length - 1; i++) {
      final item = items[i];

      if (item is MenuDivider || items[i + 1] is MenuDivider) {
        list.add(item);
      } else {
        list.addAll([item, divider]);
      }
    }

    list.add(items.last);

    return list;
  }

  /// Helper method that simplifies separation of side-by-side appearance
  /// [actions] for [MenuActionsRow].
  static List<Widget> wrapActions(List<UIMenuEntry> actions) {
    if (actions.isEmpty) return const [];

    final length = actions.length;
    if (length == 1) {
      return [Expanded(child: actions.single)];
    }

    const divider = MenuSeparator._(axis: Axis.vertical);

    return [
      for (final i in actions.take(length - 1)) ...[
        Expanded(child: i),
        divider,
      ],
      Expanded(child: actions.last),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final color =
        MenuConfig.ambientThemeOf(context).dividerTheme!.separatorColor;

    return switch (axis) {
      Axis.horizontal => Divider(
          height: _kSeparatorHeight,
          thickness: _kSeparatorHeight,
          color: color,
        ),
      Axis.vertical => VerticalDivider(
          width: _kSeparatorHeight,
          thickness: _kSeparatorHeight,
          color: color,
        ),
    };
  }
}
