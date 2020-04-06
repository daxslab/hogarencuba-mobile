import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hogarencuba/src/ui/splash.dart';
import 'package:hogarencuba/src/util/route_generator.dart';

class HogarEnCubaApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent
        ));

        return FlavorBanner(
            child: MaterialApp(
                title: 'HogarEnCuba',
                theme: ThemeData(
                        primaryColor: Color(0xFF0069D9),
                        errorColor: Color(0xFFDC3545),
                        accentColor: Color(0xFF007BFF)
                ),
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: Splash.routeName,
            ),
        );
    }
}
