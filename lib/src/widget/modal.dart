import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
    
    const Modal({
        Key key,
        this.backgroundColor,
        this.elevation,
        this.insetAnimationDuration = const Duration(milliseconds: 100),
        this.insetAnimationCurve = Curves.decelerate,
        this.shape,
        this.child,
    }) : super(key: key);
    
    final Color backgroundColor;
    
    final double elevation;
    
    final Duration insetAnimationDuration;
    
    final Curve insetAnimationCurve;
    
    final ShapeBorder shape;
    
    final Widget child;
    
    static const RoundedRectangleBorder _defaultDialogShape =
    RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)));
    static const double _defaultElevation = 24.0;
    
    @override
    Widget build(BuildContext context) {
        final DialogTheme dialogTheme = DialogTheme.of(context);
        return AnimatedPadding(
            padding: MediaQuery
                .of(context)
                .viewInsets +
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            duration: insetAnimationDuration,
            curve: insetAnimationCurve,
            child: MediaQuery.removeViewInsets(
                removeLeft: true,
                removeTop: true,
                removeRight: true,
                removeBottom: true,
                context: context,
                child: Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 280.0),
                        child: Material(
                            color: backgroundColor ??
                                dialogTheme.backgroundColor ?? Theme
                                .of(context)
                                .dialogBackgroundColor,
                            elevation: elevation ?? dialogTheme.elevation ??
                                _defaultElevation,
                            shape: shape ?? dialogTheme.shape ??
                                _defaultDialogShape,
                            type: MaterialType.card,
                            child: child,
                        ),
                    ),
                ),
            ),
        );
    }
}