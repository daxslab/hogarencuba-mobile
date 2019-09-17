import 'package:flutter/material.dart';

import 'src/ui/splash.dart';

void main() {
    runApp(HogarEnCuba());
}

class HogarEnCuba extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Color(0xFF0069D9),
                errorColor: Color(0xFFDC3545)
            ),
            home: Splash(),
        );
    }
}