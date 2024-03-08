import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Base class for entries in an iOS like menus.
@immutable
abstract base class UIMenuEntry extends Widget {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  const UIMenuEntry({super.key});
}
