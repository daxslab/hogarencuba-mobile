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
            home: Splash(),
        );
    }
}