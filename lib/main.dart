import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hogarencuba/src/hogar_en_cuba_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlavorConfig(variables: {"baseUrl": "https://hogarencuba.com"});
  runApp(HogarEnCubaApp());
}
