import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

import '../menu_items/entry.dart';

/// An [AnimatedContainer] with predefined [duration] and [curve].
///
/// Is used to animate a container on text scale factor change.
@internal
class AnimatedMenuContainer extends AnimatedContainer {
  /// Creates [AnimatedMenuContainer].
  AnimatedMenuContainer({
    super.key,
    super.constraints,
    super.alignment,
    super.padding,
    required super.child,
  }) : super(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
}

/// A widget used to create a leading widget for [UIMenuEntry] items while
/// complying with layouts defined in the Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources/>
@immutable
@internal
class LeadingWidgetLayout extends StatelessWidget {
  /// Creates [LeadingWidgetLayout].
  const LeadingWidgetLayout({
    super.key,
    this.child,
    this.height,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  /// The width of [LeadingWidgetLayout].
  static const double _kLeadingWidth = 20;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 4,
        ),
        child: _TextScaledSizedBox(
          width: _kLeadingWidth,
          height: height,
          child: child,
        ),
      );
}

/// A widget used to create a icon widget for [UIMenuEntry] items while
/// complying with layouts defined in the Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources/>
@immutable
@internal
class IconBox extends StatelessWidget {
  /// Creates [IconBox].
  const IconBox({
    super.key,
    this.color,
    required this.child,
  }) : _isSmall = false;

  /// Creates [IconBox.small].
  const IconBox.small({
    super.key,
    this.color,
    required this.child,
  }) : _isSmall = true;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The color of icon widget.
  final Color? color;

  final bool _isSmall;

  @override
  Widget build(BuildContext context) {
    // TODO(notDmDrl): migrate to textScalarOf.
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    final (double height, double width, double size) = switch (_isSmall) {
      true => (18, 18, 17),
      false => (22, 20, 22),
    };

    return _TextScaledSizedBox(
      height: height,
      width: width,
      child: Center(
        child: IconTheme.merge(
          data: IconThemeData(
            color: color,
            size: size * textScaleFactor,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// A widget used to create a icon widget for [MenuHeader] while
/// complying with layouts defined in the Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources/>
@immutable
@internal
class MenuHeaderIconLayout extends StatelessWidget {
  /// Creates [MenuHeaderIconLayout].
  const MenuHeaderIconLayout({
    super.key,
    required this.child,
    required this.color,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The color of icon.
  final Color? color;

  /// The size of [MenuHeaderIconLayout].
  static const double _kSize = 28;

  /// The size of icon at the default text scale factor.
  static const double _kIconSize = 17;

  @override
  Widget build(BuildContext context) => _TextScaledSizedBox(
        height: _kSize,
        width: _kSize,
        child: IconTheme.merge(
          data: IconThemeData(
            color: color,
            // TODO(notDmDrl): migrate to textScalarOf.
            size: MediaQuery.textScaleFactorOf(context) * _kIconSize,
          ),
          child: child,
        ),
      );
}

/// Rework of [SizedBox] with text scale factor applied internally.
@immutable
class _TextScaledSizedBox extends SingleChildRenderObjectWidget {
  /// Creates [_TextScaledSizedBox].
  const _TextScaledSizedBox({
    this.width,
    this.height,
    super.child,
  });

  /// If non-null, requires the child to have exactly this width.
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  final double? height;

  BoxConstraints _additionalConstraints(BuildContext context) {
    // TODO(notDmDrl): migrate to textScalarOf.
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);

    return BoxConstraints.tightFor(
      width: width != null ? width! * textScaleFactor : null,
      height: height != null ? height! * textScaleFactor : null,
    );
  }

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) =>
      RenderConstrainedBox(
        additionalConstraints: _additionalConstraints(context),
      );

  @override
  void updateRenderObject(
    BuildContext context,
    RenderConstrainedBox renderObject,
  ) =>
      renderObject.additionalConstraints = _additionalConstraints(context);
}
