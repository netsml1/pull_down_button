import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// A [Brightness] which a UIMenu should use for its looks.
@internal
Brightness menuBrightnessOf(BuildContext context) =>
    CupertinoTheme.maybeBrightnessOf(context) ?? Theme.of(context).brightness;
