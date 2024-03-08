import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '_fonts.dart';

/// Set of [Color] values retrieved from the Apple Design Resources Sketch and
/// Figma libraries for iOS 17 and iPadOS 17.
///
/// Naming of constants follows names present in Sketch and Figma libraries (if
/// exists).
///
/// See also:
///
/// * Apple Design Resources Sketch and Figma libraries:
/// <https://developer.apple.com/design/resources/>
@internal
abstract final class ColorThemeDefaults {
  static const Color kDividerLight = Color.fromRGBO(17, 17, 17, 0.25);
  static const Color kDividerDark = Color.fromRGBO(255, 255, 255, 0.2);

  static const Color kSeparatorLight = Color.fromRGBO(0, 0, 0, 0.08);
  static const Color kSeparatorDark = Color.fromRGBO(0, 0, 0, 0.16);

  static const Color kLabelPrimaryLight = Color.fromRGBO(0, 0, 0, 1);
  static const Color kLabelPrimaryDark = Color.fromRGBO(255, 255, 255, 1);

  static const Color kLabelSecondaryLight = Color.fromRGBO(60, 60, 67, 0.6);
  static const Color kLabelSecondaryDark = Color.fromRGBO(235, 235, 245, 0.6);

  static const Color kLabelQuaternaryLight = Color.fromRGBO(60, 60, 67, 0.18);
  static const Color kLabelQuaternaryDark = Color.fromRGBO(235, 235, 245, 0.16);

  static const Color kSystemRedLight = Color.fromRGBO(255, 59, 48, 1);
  static const Color kSystemRedDark = Color.fromRGBO(255, 69, 58, 1);
}

/// Set of [TextStyle] values retrieved from the Apple Design Resources Sketch
/// and Figma libraries for iOS 17 and iPadOS 17.
///
/// Naming of constants follows names present in Sketch and Figma libraries (if
/// exists).
///
/// See also:
///
/// * Apple Design Resources Sketch and Figma libraries:
/// <https://developer.apple.com/design/resources/>
@internal
abstract final class TextStyleThemeDefaults {
  static const TextStyle kCaption1 = TextStyle(
    inherit: false,
    fontFamily: kFontFamily,
    fontFamilyFallback: kFontFallbacks,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    textBaseline: TextBaseline.alphabetic,
    letterSpacing: 1,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none,
  );
}

/// Set of size values retrieved from the Apple Design Resources Sketch
/// and Figma libraries for iOS 17 and iPadOS 17.
///
/// Naming of constants follows names present in Sketch and Figma libraries (if
/// exists).
///
/// See also:
///
/// * Apple Design Resources Sketch and Figma libraries:
/// <https://developer.apple.com/design/resources/>
@internal
abstract final class SizeThemeDefaults {
  static const double kSeparatorHeight = 0.5;
  static const double kDividerHeight = 8;

  static const double kHeaderHeight = 64;
  static const double kHeaderActionSize = 28;
  static const double kHeaderThumbnailSize = 44;

  static const double kTitleHeight = 32;

  static const double kActionHeight = 44;
  static const double kSmallButtonHeight = 53;
  static const double kMediumButtonHeight = 60;
}
