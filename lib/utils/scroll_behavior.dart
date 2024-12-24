import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
      BuildContext context,
      Widget child,
      ScrollableDetails details,
      ) {
    return Scrollbar(
      controller: details.controller,
      child: child,
    );
  }
}