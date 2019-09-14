import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

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
                titleSpacing: 0
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
                        ),
                        Container(
                            child: CustomScrollView(
                                slivers: <Widget>[
                                    SliverList(
                                        delegate: SliverChildListDelegate([
                                            Container(
                                                padding: EdgeInsets.all(30),
                                                color: Color(0xFFDC3545),
                                                child: Column(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                        Image.asset(
                                                            "assets/images/iso.png",
                                                            fit: BoxFit.fitWidth
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 20),
                                                            child: Text(
                                                                "¿Deseas comprar o vender una casa en Cuba?",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 32,
                                                                    fontWeight: FontWeight
                                                                        .bold
                                                                ),
                                                                textAlign: TextAlign
                                                                    .center,
                                                            )
                                                        )
                                                    ],
                                                ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(20),
                                                child: Column(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                        Text(
                                                            "Preguntas frecuentes",
                                                            style: TextStyle(
                                                                fontSize: 28,
                                                                fontWeight: FontWeight
                                                                    .bold
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .only(top: 10),
                                                            child: Text(
                                                                "¿Qué debo hacer para incluir mi propiedad(casa, terreno, apartamento) en HogarEnCuba?",
                                                                style: TextStyle(
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight
                                                                        .bold
                                                                ),
                                                            ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .only(top: 10),
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    text: "Para incluir su propiedad (casa, terreno o apartamento) en el sitio web de HogarEnCuba solo debe enviarnos los datos de la misma al correo electronico: ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                    ),
                                                                    children: [
                                                                        TextSpan(
                                                                            text: "contact@hogarencuba.com",
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .blue
                                                                            ),
                                                                            recognizer: TapGestureRecognizer()
                                                                                ..onTap = () async {
                                                                                    if (await canLaunch(
                                                                                        "mailto:contact@hogarencuba.com")
                                                                                    ) {
                                                                                        await launch(
                                                                                            "mailto:contact@hogarencuba.com");
                                                                                    }
                                                                                }
                                                                        )
                                                                    ]
                                                                ))
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .only(top: 10),
                                                            child: Text(
                                                                "Los datos principales son:",
                                                            ),
                                                        ),
                                                        Html(
                                                            data:
                                                            """
                                                                    <li>Dirección</li>
                                                                    <li>Precio</li>
                                                                    <li>Nombre del propietario</li>
                                                                    <li>Telefonos del propietario</li>
                                                                    <li>Correo electrónico del propietario</li>
                                                                    <li>Descripción general de la propiedad sin olvidar tipo de cubierta (placa, tejas, fibrocemento), área total, cantidad de dormitorios, cantidad de baños, si tiene garaje. Mencione todas las habitaciones de las que se compone la vivienda (preferiblemente en el orden en que aparecen cuando uno camina por la propiedad).</li>
                                                                    <li>Fotos de la propiedad, mientras más fotos mejor pero que cada una refleje espacios diferentes de la propiedad. Evite las fotos verticales y trate de que los espacios estén ordenados y correctamente iluminados.</li>
                                                                """,
                                                            padding: EdgeInsets
                                                                .all(10),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .only(top: 10),
                                                            child: Text(
                                                                "¿Cuánto debo pagar para incluir mi propiedad(casa, terreno, apartamento) en HogarEnCuba?",
                                                                style: TextStyle(
                                                                    fontSize: 24,
                                                                    fontWeight: FontWeight
                                                                        .bold
                                                                ),
                                                            ),
                                                        ),
                                                        Html(
                                                            data:
                                                            """
                                                                    <strong>La inclusión de propiedades en HogarEnCuba es totalmente gratuita</strong>. Los agentes inmobiliarios responsables de HogarEnCuba cobran el <strong>3% del valor total de la propiedad si se vendiera</strong> por gestiones relacionadas con el sitio web.
                                                                """,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        )
                                                    ],
                                                ),
                                            )
                                        ]),
                                    ),
                                    SliverFillRemainingBoxAdapter(
                                        child: Container(
                                            alignment: Alignment.bottomCenter,
                                            color: Color(0xFFDC3545),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: 30,
                                                            top: 20,
                                                            right: 30
                                                        ),
                                                        child: Text(
                                                            "HogarEnCuba © 2013 - 2019",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16
                                                            ),
                                                        )
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: 30,
                                                            top: 10,
                                                            right: 30
                                                        ),
                                                        child: RichText(
                                                            text: TextSpan(
                                                                text: "Aplicación desarrollada por ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                ),
                                                                children: [
                                                                    TextSpan(
                                                                        text: "Daxslab",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white
                                                                        ),
                                                                        recognizer: TapGestureRecognizer()
                                                                            ..onTap = () async {
                                                                                if (await canLaunch(
                                                                                    "https://www.daxslab.com")
                                                                                ) {
                                                                                    await launch(
                                                                                        "https://www.daxslab.com");
                                                                                }
                                                                            }
                                                                    )
                                                                ]
                                                            ),
                                                        )
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            vertical: 20
                                                        ),
                                                        child: Divider(
                                                            height: 1,
                                                            color: Colors
                                                                .black26,
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            left: 30,
                                                            right: 30,
                                                            bottom: 20
                                                        ),
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize
                                                                .max,
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .spaceBetween,
                                                            children: <Widget>[
                                                                IconButton(
                                                                    icon: Icon(
                                                                        FontAwesomeIcons
                                                                            .phoneAlt,
                                                                        color: Colors
                                                                            .white,),
                                                                    onPressed: () async {
                                                                        if (await canLaunch(
                                                                            "tel:+5358074332")
                                                                        ) {
                                                                            await launch(
                                                                                "tel:+5358074332");
                                                                        }
                                                                    }
                                                                ),
                                                                IconButton(
                                                                    icon: Icon(
                                                                        Icons
                                                                            .email,
                                                                        color: Colors
                                                                            .white,),
                                                                    onPressed: () async {
                                                                        if (await canLaunch(
                                                                            "mailto:info@daxslab.com")
                                                                        ) {
                                                                            await launch(
                                                                                "mailto:info@daxslab.com");
                                                                        }
                                                                    }
                                                                ),
                                                                IconButton(
                                                                    icon: Icon(
                                                                        FontAwesomeIcons
                                                                            .telegramPlane,
                                                                        color: Colors
                                                                            .white,),
                                                                    onPressed: () async {
                                                                        if (await canLaunch(
                                                                            "https://t.me/daxslab")
                                                                        ) {
                                                                            await launch(
                                                                                "https://t.me/daxslab");
                                                                        } else {
                                                                            await launch(
                                                                                "https://t.me/daxslab");
                                                                        }
                                                                    }
                                                                ),
                                                                IconButton(
                                                                    icon: Icon(
                                                                        FontAwesomeIcons
                                                                            .facebookF,
                                                                        color: Colors
                                                                            .white,),
                                                                    onPressed: () async {
                                                                        if (await canLaunch(
                                                                            "https://m.me/daxslab")
                                                                        ) {
                                                                            await launch(
                                                                                "https://m.me/daxslab"
                                                                            );
                                                                        } else
                                                                        if (await canLaunch(
                                                                            "https://fb.me/daxslab")
                                                                        ) {
                                                                            await launch(
                                                                                "https://fb.me/daxslab");
                                                                        } else {
                                                                            await launch(
                                                                                "https://facebook.com/daxslab"
                                                                            );
                                                                        }
                                                                    }
                                                                ),
                                                                IconButton(
                                                                    icon: Icon(
                                                                        FontAwesomeIcons
                                                                            .twitter,
                                                                        color: Colors
                                                                            .white,),
                                                                    onPressed: () async {
                                                                        if (await canLaunch(
                                                                            "twitter://user?screen_name=daxslab")
                                                                        ) {
                                                                            await launch(
                                                                                "twitter://user?screen_name=daxslab"
                                                                            );
                                                                        } else {
                                                                            await launch(
                                                                                "https://twitter.com/daxslab"
                                                                            );
                                                                        }
                                                                    }
                                                                )
                                                            ],
                                                        ),
                                                    )
                                                ],
                                            ),
                                        ),
                                    )
                                ],
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}