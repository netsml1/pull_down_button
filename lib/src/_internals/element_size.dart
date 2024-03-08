import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../menu_items/entry.dart';
import 'content_size_category.dart';

/// Signature for the callback invoked when the minimum size of [UIMenuEntry]
/// item needs to be resolved.
///
/// Used by [ElementSize.resolve].
@internal
typedef ElementSizeResolver = double Function(ContentSizeCategory category);

/// Used to configure look and height of various [UIMenuEntry] items.
///
/// See also:
///
/// * preferredElementSize:
/// <https://developer.apple.com/documentation/uikit/uimenu/4013313-preferredelementsize>
/// * displayAsPalette:
/// <https://developer.apple.com/documentation/uikit/uimenu/options/4195440-displayaspalette>
@internal
enum ElementSize {
  /// Compact layout, small icon-only representation.
  ///
  /// Maximum 6 items.
  palette(_resolveSmall),

  /// Compact layout, icon-only representation.
  ///
  /// Maximum 4 items.
  small(_resolveSmall),

  /// Medium layout, icon and title vertically aligned.
  ///
  /// Maximum 3 items.
  medium(_resolveMedium),

  /// Large layout, title and icon horizontally aligned.
  large(_resolveLarge),

  /// Extra large layout, title and icon horizontally aligned. Has a subtitle or
  /// large leading widget.
  extraLarge(_resolveExtraLarge),

  /// Menu title layout.
  title(_resolveTitle);

  const ElementSize(this.resolve);

  /// Called when the minimum size of [UIMenuEntry] item needs to be resolved.
  final ElementSizeResolver resolve;
}

/// Minimum allowed height for [ElementSize.large], [ElementSize.small], and
/// [ElementSize.palette].
///
/// [ElementSize.large] should use returned value as a `minHeight` for its
/// constraints. [ElementSize.small] and [ElementSize.palette] should use
/// returned value as a fixed height.
///
/// Values were resolved based on a direct comparison with the native variant
/// for each [ContentSizeCategory].
///
/// Base is 44px ([kMinInteractiveDimensionCupertino]). Base value was resolved
/// based on layouts defined in the Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources>.
double _resolveLarge(ContentSizeCategory category) => switch (category) {
      ContentSizeCategory.extraSmall => 38,
      ContentSizeCategory.small => 40,
      ContentSizeCategory.medium => 42,
      ContentSizeCategory.large => 44,
      ContentSizeCategory.extraLarge => 48,
      ContentSizeCategory.extraExtraLarge => 52,
      ContentSizeCategory.extraExtraExtraLarge => 58,
      ContentSizeCategory.accessibilityMedium => 68,
      ContentSizeCategory.accessibilityLarge => 80,
      ContentSizeCategory.accessibilityExtraLarge => 96,
      ContentSizeCategory.accessibilityExtraExtraLarge => 112,
      ContentSizeCategory.accessibilityExtraExtraExtraLarge => 124
    };

/// Minimum allowed height for [ElementSize.small].
///
/// [ElementSize.small] should use returned value as a fixed height.
///
/// Values were eyeballed based on a direct comparison with the native variant
/// for each [ContentSizeCategory].
///
/// Returned value is always 1.2 times bigger than [_resolveLarge].
///
/// Base is 53px. Base value was resolved based on layouts defined in the
/// Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources>.
double _resolveSmall(ContentSizeCategory category) =>
    (_resolveLarge(category) * 1.2).ceilToDouble();

/// Minimum allowed height for [ElementSize.medium].
///
/// [ElementSize.medium] should use returned value as a fixed height.
///
/// Values were eyeballed based on a direct comparison with the native variant
/// for each [ContentSizeCategory].
///
/// Returned value is always 1.36 times bigger than [_resolveLarge].
///
/// Base is 60px. Base value was resolved based on layouts defined in the
/// Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources>.
double _resolveMedium(ContentSizeCategory category) =>
    (_resolveLarge(category) * 1.36).ceilToDouble();

/// Minimum allowed height for [ElementSize.extraLarge].
///
/// [ElementSize.extraLarge] should use returned value as a `minHeight` for its
/// constraints.
///
/// Values were eyeballed based on a direct comparison with the native variant
/// for each [ContentSizeCategory].
///
/// Returned value is always 1.45 times bigger than [_resolveLarge].
///
/// Base is 64px. Base value was resolved based on layouts defined in the
/// Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources>.
double _resolveExtraLarge(ContentSizeCategory category) =>
    (_resolveLarge(category) * 1.45).ceilToDouble();

/// Minimum allowed height for [ElementSize.title].
///
/// [ElementSize.title] should use returned value as a `minHeight` for its
/// constraints.
///
/// Values were eyeballed based on a direct comparison with the native variant
/// for each [ContentSizeCategory].
///
/// Returned value is always 0.72 times the size of [_resolveLarge].
///
/// Base is 32px. Base value was resolved based on layouts defined in the
/// Apple Design Resources Sketch file.
///
/// See also:
///
/// * Apple Design Resources Sketch file:
/// <https://developer.apple.com/design/resources>.
double _resolveTitle(ContentSizeCategory category) =>
    (_resolveLarge(category) * 0.72).ceilToDouble();
