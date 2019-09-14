import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hogarencuba/src/model/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDetails extends StatefulWidget {
    
    final HomeEntity data;
    
    const HomeDetails({Key key, this.data}) : super(key: key);
    
    @override
    State<StatefulWidget> createState() {
        return HomeDetailsState(data);
    }
}

class HomeDetailsState extends State<HomeDetails> {
    
    final HomeEntity data;
    
    HomeDetailsState(this.data);
    
    @override
    Widget build(BuildContext context) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent
            ));
        
        return Scaffold(
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
                                    SliverAppBar(
                                        title: Text(
                                            data.code,
                                            style: TextStyle(
                                                color: Colors.white
                                            )),
                                        backgroundColor: Color(0xFFDC3545),
                                        expandedHeight: 200.0,
                                        pinned: true,
                                        floating: true,
                                        titleSpacing: 0,
                                        flexibleSpace: FlexibleSpaceBar(
                                            background: CachedNetworkImage(
                                                imageUrl: data.firstImageUrl !=
                                                    null
                                                    ? data.firstImageUrl
                                                    : "http://www.hogarencuba.com/images/t_phantom-house.jpg",
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url,
                                                    error) =>
                                                    Image.asset(
                                                        "assets/images/home_without_picture.jpg",
                                                        fit: BoxFit.cover,
                                                    )
                                            ),
                                        ),
                                    ),
                                    SliverList(
                                        delegate: SliverChildListDelegate(
                                            [
                                                Container(
                                                    padding: EdgeInsets.all(20),
                                                    child: Text(
                                                        data.title,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight
                                                                .bold
                                                        ),
                                                    ),
                                                ),
                                                Container(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 20
                                                    ),
                                                    child: Contact()
                                                ),
                                                Container(
                                                    padding: EdgeInsets.all(20),
                                                    child: Text(
                                                        data.description
                                                    )
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20,
                                                        top: 10,
                                                        right: 20,
                                                        bottom: 20),
                                                    child: Contact()
                                                )
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                        )
                    ],
                )
            ),
        );
    }
}

class Contact extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisSize: MainAxisSize
                .max,
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween,
            children: <Widget>[
                IconButton(
                    icon: Icon(
                        FontAwesomeIcons
                            .phoneAlt),
                    onPressed: () async {
                        if (await canLaunch(
                            "tel:+5352381595")
                        ) {
                            await launch(
                                "tel:+5352381595");
                        }
                    },
                ),
                IconButton(
                    icon: Icon(
                        FontAwesomeIcons
                            .sms),
                    onPressed: () async {
                        if (await canLaunch(
                            "sms:+5352381595")) {
                            await launch(
                                "sms:+5352381595");
                        }
                    },
                ),
                IconButton(
                    icon: Icon(
                        FontAwesomeIcons
                            .whatsapp),
                    onPressed: () async {
                        if (await canLaunch(
                            "whatsapp://send?phone=+5352381595")
                        ) {
                            await launch(
                                "whatsapp://send?phone=+5352381595");
                        }
                    },
                ),
                IconButton(
                    icon: Icon(
                        Icons
                            .email),
                    onPressed: () async {
                        if (await canLaunch(
                            "mailto:contact@hogarencuba.com")
                        ) {
                            await launch(
                                "mailto:contact@hogarencuba.com");
                        }
                    }
                )
            ],
        );
    }
}