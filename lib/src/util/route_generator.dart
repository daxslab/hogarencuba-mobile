import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hogarencuba/src/ui/about.dart';
import 'package:hogarencuba/src/ui/home.dart';
import 'package:hogarencuba/src/ui/home_details.dart';
import 'package:hogarencuba/src/ui/splash.dart';

class RouteGenerator {
    static Route<dynamic> generateRoute(RouteSettings settings) {
        final args = settings.arguments;

        switch (settings.name) {
            case Splash.routeName:
                SystemChrome.setEnabledSystemUIOverlays([]);
                return MaterialPageRoute(builder: (_) => Splash());

            case Home.routeName:
                SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                return MaterialPageRoute(builder: (_) => Home());

            case HomeDetails.routeName:
                SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                return MaterialPageRoute(builder: (_) => HomeDetails(data: args));

            case About.routeName:
                SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                return MaterialPageRoute(builder: (_) => About());

            default:
                SystemChrome.setEnabledSystemUIOverlays([]);
                return MaterialPageRoute(builder: (_) => Splash());
        }
    }
}