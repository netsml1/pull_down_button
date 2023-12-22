import 'package:flutter/material.dart';

import '../_internals/element_size.dart';
import '../_internals/item_layout.dart';
import '../_internals/menu_config.dart';
import '../theme/title_theme.dart';
import 'entry.dart';

/// Signature used by [MenuTitle.builder] to create a custom title widget when a
/// default [Text] is not sufficient enough.
///
/// [textStyle] is a resolved style from the ambient [MenuTitleTheme] and a
/// [MenuTitle.style].
typedef MenuTitleBuilder = Widget Function(
  BuildContext context,
  TextStyle textStyle,
);

/// Used to configure how [MenuTitle.title] is aligned.
enum MenuTitleAlignment {
  /// [MenuTitle.title] is aligned at the start edge (with applied padding)
  /// of [MenuTitle] widget.
  start,

  /// [MenuTitle.title] is aligned at the center
  /// of [MenuTitle] widget.
  center;
}

/// The optional title of the iOS like menus that is usually displayed at the
/// top of the menu.
@immutable
class MenuTitle extends StatelessWidget implements UIMenuEntry {
  /// Creates a title for a menu by providing a [String] value.
  const MenuTitle({
    super.key,
    required String this.title,
    this.alignment = MenuTitleAlignment.start,
    this.style,
  }) : titleBuilder = null;

  /// Creates a title for a menu by providing a custom builder.
  const MenuTitle.builder({
    super.key,
    required MenuTitleBuilder this.titleBuilder,
    this.alignment = MenuTitleAlignment.start,
    this.style,
  }) : title = null;

  /// Text that describes menu's or sub-menu's.
  ///
  /// Typically has a short one-two words content.
  final String? title;

  /// Builder that provides [BuildContext] as well as the resolved text style
  /// to pass to any custom menu title widget.
  final MenuTitleBuilder? titleBuilder;

  /// The alignment of [title].
  ///
  /// Defaults to [MenuTitleAlignment.start].
  final MenuTitleAlignment alignment;

  /// The text style of the title.
  ///
  /// If this property is null, then the value from the ambient
  /// [MenuTitleTheme] is used.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = MenuConfig.ambientThemeOf(context).titleTheme!;
    final hasLeading = MenuConfig.hasLeadingOf(context);
    final contentSize = MenuConfig.contentSizeCategoryOf(context);

    final resolvedStyle = theme.textStyle!.merge(style);
    final minHeight = ElementSize.title.resolve(contentSize);
    final isAlignedToStart = alignment == MenuTitleAlignment.start;
    final isAlignedToLeading = hasLeading && isAlignedToStart;

    var child = titleBuilder?.call(context, resolvedStyle) ??
        Text(
          title!,
          style: resolvedStyle,
          textAlign: isAlignedToStart ? TextAlign.start : TextAlign.center,
        );

    if (isAlignedToLeading) {
      child = Row(
        children: [
          const LeadingWidgetLayout(),
          Expanded(child: child),
        ],
      );
    }

    return AnimatedMenuContainer(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: EdgeInsetsDirectional.only(
        start: isAlignedToLeading ? 9 : 16,
        end: 16,
        top: 8,
        bottom: 8,
      ),
      alignment: isAlignedToStart
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.center,
      child: child,
    );
  }
}
