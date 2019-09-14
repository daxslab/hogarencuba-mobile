import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

class Splash extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIOverlays([]);
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent
            ));
        
        Future.delayed(const Duration(seconds: 4), () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home()));
        });
        
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