import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent
            ));
        
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xFFDC3545),
                elevation: 0.0,
                title: Text(
                    "Acerca de",
                    style: TextStyle(
                        color: Colors.white
                    ),
                ),
                titleSpacing: 0,
            ),
            body: Container(
                color: Colors.white,
                child: Stack(
                    children: <Widget>[
                        Image.asset(
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
                    ],
                ),
            ),
        );
    }
}