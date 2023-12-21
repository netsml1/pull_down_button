import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// A set of animation utils.
///
/// All of the values were eyeballed using the iOS 16 Simulator.
@internal
abstract final class UIMenuAnimation {
  /// UIMenu open / close animation duration.
  ///
  /// The value was deducted using comparison with native variant.
  static const Duration kDuration = Duration(milliseconds: 300);

  /// UIMenu animation curve on size change (ex. on text scale change).
  ///
  /// Eyeballed by comparison with native variant.
  static const Curve kOnSizeChangeCurve = Curves.fastOutSlowIn;

  /// UIMenu animation curve used when opening a menu.
  ///
  /// A cubic animation curve that starts slowly and ends with an overshoot of
  /// its bounds before reaching its end.
  static const Curve kCurve = Cubic(0.075, 0.82, 0.4, 1.065);

  /// UIMenu animation curve used when closing a menu.
  static const Curve kCurveReverse = Curves.easeIn;

  /// A curve tween for UIMenu shadow.
  static final CurveTween shadowTween = CurveTween(
    curve: const Interval(1 / 3, 1),
  );
}

/// An animation that clamps its parent value between `0` and `1`.
///
/// Since [UIMenuAnimation.kCurve] has an overshoot at the end and only
/// [ScaleTransition] requires it, [ClampedAnimation] is introduced for every
/// other *Transition* widget.
@internal
class ClampedAnimation extends Animation<double>
    with AnimationWithParentMixin<double> {
  /// Creates [ClampedAnimation].
  ClampedAnimation(this.parent);

  @override
  final Animation<double> parent;

  @override
  double get value => parent.value.clamp(0, 1);
}
