import 'package:flutter/material.dart';
import 'package:hogarencuba/src/ui/home.dart';

class Splash extends StatefulWidget {
    Splash({Key key}) : super(key: key);

    static const String routeName = 'splash';

    @override
    _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

    bool delayed = false;

    @override
    Widget build(BuildContext context) {

        if (!delayed) {
            delayed = true;
            Future.delayed(const Duration(seconds: 4), () {
                Navigator.of(context).pushReplacementNamed(Home.routeName);
            });
        }

        return Container(
                color: Colors.white,
                child: Stack(
                        children: <Widget>[
                            Opacity(
                                    opacity: 0.6,
                                    child: Image.asset(
                                        "assets/images/background.png",
                                        fit: BoxFit.cover,
                                        width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                        height: MediaQuery
                                                .of(context)
                                                .size
                                                .height,
                                    )
                            ),
                            Center(
                                    child: Image.asset(
                                        "assets/images/iso_splash.png",
                                        fit: BoxFit.contain,
                                        width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.55,
                                    )
                            )
                        ]
                )
        );
    }
}

