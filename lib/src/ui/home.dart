import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hogarencuba/src/model/home.dart';
import 'package:hogarencuba/src/util/colors.dart';
import 'package:localstorage/localstorage.dart';

import '../api/blocs.dart';
import 'about.dart';
import 'home_details.dart';

class Home extends StatefulWidget {
    
    @override
    State<StatefulWidget> createState() {
        return HomeState();
    }
}

class HomeState extends State<Home> {
    
    final LocalStorage storage = LocalStorage('dataStorage');
    
    @override
    void initState() {
        super.initState();
        blocs.homes();
    }
    
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
                    "HogarEnCuba",
                    style: TextStyle(
                        color: Colors.white
                    ),
                ),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () {
                        
                        }),
                    IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        About()
                                )
                            );
                        })
                ],
            
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
                        StreamBuilder<Response>(
                            stream: blocs.subject.stream,
                            builder: (context,
                                AsyncSnapshot<Response> snapshot) {
                                if (snapshot.hasData) {
                                    var data = snapshot.data.data;
                                    
                                    storage.setItem("data", data);
                                    
                                    var list = data as List;
                                    
                                    List<HomeEntity> homes = list.map((i) =>
                                        HomeEntity.fromJson(i))
                                        .toList();
                                    
                                    return ListView.builder(
                                        itemCount: homes.length,
                                        itemBuilder: (context, index) {
                                            return HomeCard(
                                                data: homes[index]);
                                        }
                                    );
                                } else if (snapshot.hasError) {
                                    return FutureBuilder(
                                        future: storage.ready,
                                        builder: (BuildContext context,
                                            snapshot) {
                                            if (snapshot.data == true) {
                                                List<dynamic> list = storage
                                                    .getItem("data");
                                                
                                                if (list != null) {
                                                    List<
                                                        HomeEntity> homes = list
                                                        .map((i) =>
                                                        HomeEntity.fromJson(i))
                                                        .toList();
                                                    
                                                    return ListView.builder(
                                                        itemCount: homes.length,
                                                        itemBuilder: (context,
                                                            index) {
                                                            return HomeCard(
                                                                data: homes[index]);
                                                        }
                                                    );
                                                } else {
                                                    return Container(
                                                        padding: EdgeInsets.all(
                                                            30),
                                                        child: Center(
                                                            child: Text(
                                                                "No hay datos para mostrar."),
                                                        ),
                                                    );
                                                }
                                            } else {
                                                return Center(
                                                    child: CircularProgressIndicator()
                                                );
                                            }
                                        },
                                    );
                                } else {
                                    return Center(
                                        child: CircularProgressIndicator()
                                    );
                                }
                            }
                        )
                    ],
                )
            )
        );
    }
}

class HomeCard extends StatelessWidget {
    
    final HomeEntity data;
    
    const HomeCard({Key key, @required this.data}) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        var color;
        if (data.price < 10000) {
            color = CardColors.red;
        } else if (data.price >= 10000 && data.price < 50000) {
            color = CardColors.gray;
        } else if (data.price >= 50000 && data.price < 100000) {
            color = CardColors.blue;
        } else {
            color = CardColors.green;
        }
        
        return InkWell(
            onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeDetails(data: data)
                    )
                );
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Card(
                    elevation: 0.0,
                    color: color,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(1),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                CachedNetworkImage(
                                    imageUrl: data.firstImageUrl != null
                                        ? data.firstImageUrl
                                        : "http://www.hogarencuba.com/images/t_phantom-house.jpg",
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, url) =>
                                        Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CircularProgressIndicator()
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/home_without_picture.jpg",
                                            fit: BoxFit.fitWidth,
                                        )
                                ),
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                    Expanded(
                                                        child: Text(
                                                            "${data
                                                                .code}: ${data
                                                                .title}",
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight: FontWeight
                                                                    .bold
                                                            )
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(left: 20),
                                                        child: Icon(
                                                            Icons.star_border,
                                                            size: 32,
                                                            color: Colors.white)
                                                    )
                                                ],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20)
                                            ),
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                    Expanded(
                                                        child: RichText(
                                                            text: TextSpan(
                                                                text: data
                                                                    .location,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight: FontWeight
                                                                        .bold
                                                                ),
                                                                children: <
                                                                    TextSpan>[
                                                                    TextSpan(
                                                                        text: ": ${data
                                                                            .description}",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontWeight: FontWeight
                                                                                .normal
                                                                        )
                                                                    )
                                                                ]
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 3
                                                        ),
                                                    )
                                                ],
                                            )
                                        ],
                                    ),
                                ),
                                Divider(
                                    color: Colors.black26,
                                    height: 4,
                                ),
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        children: <Widget>[
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                    Icon(
                                                        FontAwesomeIcons.bed,
                                                        color: Colors.white,
                                                        size: 15,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            right: 10),
                                                    ),
                                                    Text(
                                                        data.bedroomsCount
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                    )
                                                ],
                                            ),
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                    Icon(
                                                        FontAwesomeIcons.bath,
                                                        color: Colors.white,
                                                        size: 15,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            right: 10),
                                                    ),
                                                    Text(
                                                        data.bathroomsCount
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                    )
                                                ],
                                            ),
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                    Icon(
                                                        FontAwesomeIcons.car,
                                                        color: Colors.white,
                                                        size: 15,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(
                                                            right: 10),
                                                    ),
                                                    Text(
                                                        data.bedroomsCount > 0
                                                            ? data.bedroomsCount
                                                            .toString()
                                                            : "No",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                    )
                                                ],
                                            ),
                                        ],
                                    )
                                )
                            ],
                        ),
                    ),
                )
            )
        );
    }
}