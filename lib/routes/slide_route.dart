import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final String? direction;

  SlideRoute({required this.page, this.direction})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                        position: Tween(
                                begin: Offset(direction == 'right' ? -1 : 1, 0),
                                end: Offset.zero)
                            .chain(CurveTween(curve: Curves.ease))
                            .animate(animation),
                        child: child));
}
