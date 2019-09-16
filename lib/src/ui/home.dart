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
    
    final _formKey = GlobalKey<FormState>();
    final LocalStorage storage = LocalStorage('dataStorage');
    
    final List<String> types = [
        "--Cualquiera--",
        "Casa",
        "Apartamento",
        "Terreno"
    ];
    
    String typeValue = "One";
    final minPriceController = TextEditingController();
    final maxPriceController = TextEditingController();
    
    String province;
    String city;
    String type;
    int minPrice;
    int maxPrice;
    int bedrooms;
    int bathrooms;
    
    bool visibilityFilter;
    
    @override
    void initState() {
        super.initState();
        setState(() {
            this.visibilityFilter = true;
        });
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
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    showFormToSearch();
                },
                child: Icon(Icons.filter_list),
            ),
            body: Container(
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
                            ),
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
                                    
                                    if (this.province != null) {
                                        homes = homes.where((home) =>
                                            home.location.trim()
                                                .startsWith(
                                                this.province))
                                            .toList();
                                    }
                                    
                                    if (this.city != null) {
                                        homes = homes.where((home) =>
                                            home.location.trim()
                                                .endsWith(
                                                this.city))
                                            .toList();
                                    }
                                    
                                    if (this.type != null) {
                                        homes = homes.where((home) =>
                                        home.type.trim() ==
                                            this.type).toList();
                                    }
                                    
                                    if (this.minPrice != null) {
                                        homes = homes.where((home) =>
                                        home.price >=
                                            this.minPrice).toList();
                                    }
                                    
                                    if (this.maxPrice != null) {
                                        homes = homes.where((home) =>
                                        home.price <=
                                            this.maxPrice).toList();
                                    }
                                    
                                    if (homes.isNotEmpty) {
                                        return ListView.builder(
                                            itemCount: homes.length,
                                            itemBuilder: (context, index) {
                                                return HomeCard(
                                                    data: homes[index]);
                                            }
                                        );
                                    } else {
                                        return NoProperties();
                                    }
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
                                                    
                                                    if (this.province != null) {
                                                        homes = homes.where((
                                                            home) =>
                                                            home.location.trim()
                                                                .startsWith(
                                                                this.province))
                                                            .toList();
                                                    }
                                                    
                                                    if (this.city != null) {
                                                        homes = homes.where((
                                                            home) =>
                                                            home.location.trim()
                                                                .endsWith(
                                                                this.city))
                                                            .toList();
                                                    }
                                                    
                                                    if (this.type != null) {
                                                        homes = homes.where((
                                                            home) =>
                                                        home.type.trim() ==
                                                            this.type).toList();
                                                    }
                                                    
                                                    if (this.minPrice != null) {
                                                        homes = homes.where((
                                                            home) =>
                                                        home.price >=
                                                            this.minPrice)
                                                            .toList();
                                                    }
                                                    
                                                    if (this.maxPrice != null) {
                                                        homes = homes.where((
                                                            home) =>
                                                        home.price <=
                                                            this.maxPrice)
                                                            .toList();
                                                    }
                                                    
                                                    if (homes.isNotEmpty) {
                                                        return ListView.builder(
                                                            itemCount: homes
                                                                .length,
                                                            itemBuilder: (
                                                                context,
                                                                index) {
                                                                return HomeCard(
                                                                    data: homes[index]);
                                                            }
                                                        );
                                                    } else {
                                                        return NoProperties();
                                                    }
                                                } else {
                                                    return NoProperties();
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
    
    void showFormToSearch() {
        showGeneralDialog(
            context: context,
            barrierColor: Colors.black12.withOpacity(0.6),
            barrierDismissible: false,
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, __, ___) {
                return GestureDetector(
                    onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: SizedBox.expand(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 30
                            ),
                            child: Material(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20
                                                ),
                                                child: Column(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    children: <Widget>[
                                                        Text(
                                                            "¿Qué estás buscando?",
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight: FontWeight
                                                                    .bold
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 20),
                                                            child: Divider(
                                                                color: Colors
                                                                    .black26,
                                                                height: 1,
                                                            ),
                                                        )
                                                    ],
                                                ),
                                            ),
                                            Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20),
                                                    child: ListView(
                                                        children: <Widget>[
                                                            TextFormField(
                                                                decoration: InputDecoration(
                                                                    labelText: "Precio mínimo",
                                                                    errorMaxLines: 3,
                                                                    prefixText: "\$ ",
                                                                    prefixStyle: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold
                                                                    ),
                                                                    suffixText: " CUC",
                                                                    suffixStyle: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold
                                                                    )
                                                                ),
                                                                keyboardType: TextInputType
                                                                    .number,
                                                                controller: minPriceController,
                                                                validator: (
                                                                    value) {
                                                                    if (value
                                                                        .isNotEmpty &&
                                                                        maxPriceController
                                                                            .text
                                                                            .isNotEmpty &&
                                                                        int
                                                                            .parse(
                                                                            maxPriceController
                                                                                .text) <
                                                                            int
                                                                                .parse(
                                                                                value)) {
                                                                        return "El precio mínimo debe ser menor o igual que el precio máximo";
                                                                    }
                                                                    return null;
                                                                }
                                                            ),
                                                            TextFormField(
                                                                decoration: InputDecoration(
                                                                    labelText: "Precio máximo",
                                                                    errorMaxLines: 3,
                                                                    prefixText: "\$ ",
                                                                    prefixStyle: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold
                                                                    ),
                                                                    suffixText: " CUC",
                                                                    suffixStyle: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold
                                                                    )
                                                                ),
                                                                keyboardType: TextInputType
                                                                    .number,
                                                                controller: maxPriceController,
                                                                validator: (
                                                                    value) {
                                                                    if (value
                                                                        .isNotEmpty &&
                                                                        minPriceController
                                                                            .text
                                                                            .isNotEmpty &&
                                                                        int
                                                                            .parse(
                                                                            minPriceController
                                                                                .text) >
                                                                            int
                                                                                .parse(
                                                                                value)) {
                                                                        return "El precio máximo debe ser mayor o igual que el precio mínimo";
                                                                    }
                                                                    return null;
                                                                }
                                                            )
                                                        ],
                                                    )
                                                )
                                            ),
                                            Column(
                                                mainAxisSize: MainAxisSize
                                                    .min,
                                                children: <Widget>[
                                                    Divider(
                                                        color: Colors
                                                            .black26,
                                                        height: 1,
                                                    ),
                                                    Row(
                                                        mainAxisSize: MainAxisSize
                                                            .max,
                                                        children: <
                                                            Widget>[
                                                            Expanded(
                                                                child: MaterialButton(
                                                                    child: Text(
                                                                        "Cerrar"),
                                                                    onPressed: () {
                                                                        close();
                                                                        Navigator
                                                                            .of(
                                                                            context)
                                                                            .pop();
                                                                    },
                                                                    elevation: 0,
                                                                    focusElevation: 0,
                                                                    hoverElevation: 0,
                                                                    highlightElevation: 0,
                                                                    disabledElevation: 0,
                                                                    padding: EdgeInsets
                                                                        .all(
                                                                        20),
                                                                ),
                                                            ),
                                                            Expanded(
                                                                child: MaterialButton(
                                                                    child: Text(
                                                                        "Buscar"),
                                                                    onPressed: () {
                                                                        if (_formKey
                                                                            .currentState
                                                                            .validate()) {
                                                                            search();
                                                                            Navigator
                                                                                .of(
                                                                                context)
                                                                                .pop();
                                                                        }
                                                                    },
                                                                    elevation: 0,
                                                                    focusElevation: 0,
                                                                    hoverElevation: 0,
                                                                    highlightElevation: 0,
                                                                    disabledElevation: 0,
                                                                    textColor: Colors
                                                                        .blue,
                                                                    padding: EdgeInsets
                                                                        .all(
                                                                        20),
                                                                ),
                                                            )
                                                        ],
                                                    )
                                                ],
                                            )
                                        ],
                                    )
                                )
                            ),
                        ),
                    )
                );
            }
        );
    }
    
    void close() {
        this.typeValue = this.type;
        this.minPriceController.text =
        (this.minPrice != null) ? this.minPrice.toString() : "";
        this.maxPriceController.text =
        (this.maxPrice != null) ? this.maxPrice.toString() : "";
    }
    
    void search() {
        setState(() {
            this.type = this.typeValue;
            if (this.minPriceController.text.isNotEmpty) {
                this.minPrice = int.parse(this.minPriceController.text);
            } else {
                this.minPrice = null;
            }
            if (this.maxPriceController.text.isNotEmpty) {
                this.maxPrice = int.parse(this.maxPriceController.text);
            } else {
                this.maxPrice = null;
            }
        });
    }
}

class NoProperties extends StatelessWidget {
    
    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets
                .all(
                30),
            child: Center(
                child: Text(
                    "No hay propiedades para mostrar."),
            ),
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
                padding: EdgeInsets.all(10),
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
                                                                                .normal,
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
                                                        data.garageCount > 0
                                                            ? data.garageCount
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