import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hogarencuba/src/api/blocs.dart';
import 'package:hogarencuba/src/model/home.dart';
import 'package:hogarencuba/src/util/colors.dart';
import 'package:hogarencuba/src/widget/modal.dart';
import 'package:localstorage/localstorage.dart';
import 'package:toast/toast.dart';

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
    
    final Map<String, dynamic> location = {
        "Pinar del Río": [
            "--Cualquiera--",
            "Consolación del Sur",
            "Guane",
            "La Palma",
            "Mantua",
            "Minas de Matahambre",
            "Pinar del Río",
            "San Juan y Martínez",
            "San Luis",
            "Sandino",
            "Viñales",
            "Los Palacios"
        ],
        "Artemisa": [
            "--Cualquiera--",
            "Mariel",
            "Guanajay",
            "Caimito",
            "Bauta",
            "San Antonio de los Baños",
            "Güira de Melena",
            "Alquízar",
            "Artemisa",
            "Bahía Honda",
            "Candelaria",
            "San Cristóbal"
        ],
        "La Habana": [
            "--Cualquiera--",
            "La Lisa",
            "Playa",
            "Arroyo Naranjo",
            "Boyeros",
            "Centro Habana",
            "Cerro",
            "Cotorro",
            "Diez de Octubre",
            "Guanabacoa",
            "La Habana del Este",
            "La Habana Vieja",
            "Marianao",
            "Plaza de la Revolución",
            "Regla",
            "San Miguel del Padrón"
        ],
        "Mayabeque": [
            "--Cualquiera--",
            "Jaruco",
            "Santa Cruz del Norte",
            "Madruga",
            "Nueva Paz",
            "San Nicolás de Bari",
            "Güines",
            "Melena del Sur",
            "Batabanó",
            "Quivicán"
        ],
        "Matanzas": [
            "--Cualquiera--",
            "Calimete",
            "Cárdenas",
            "Ciénaga de Zapata",
            "Colón",
            "Jagüey Grande",
            "Jovellanos",
            "Limonar",
            "Los Arabos",
            "Martí",
            "Matanzas",
            "Pedro Betancourt",
            "Perico",
            "Unión de Reyes"
        ],
        "Villa Clara": [
            "--Cualquiera--",
            "Caibarién",
            "Camajuaní",
            "Cifuentes",
            "Corralillo",
            "Encrucijada",
            "Manicaragua",
            "Placetas",
            "Quemado de Güines",
            "Ranchuelos",
            "Remedios",
            "Sagüa la Grande",
            "Santa Clara",
            "Santo Domingo"
        ],
        "Cienfuegos": [
            "--Cualquiera--",
            "Cienfuegos",
            "Cruces",
            "Palmira",
            "Rodas",
            "Abreus",
            "Aguada de pasajeros",
            "Cumanayagüa",
            "Lajas"
        ],
        "Sancti Spiritus": [
            "--Cualquiera--",
            "Sancti Spíritus",
            "Trinidad",
            "Cabaiguán",
            "Yaguajay",
            "Jatibonico",
            "Taguasco",
            "Fomento",
            "La Sierpe"
        ],
        "Ciego de Ávila": [
            "--Cualquiera--",
            "Ciego de Ávila",
            "Morón",
            "Chambas",
            "Ciro Redondo",
            "Majagua",
            "Florencia",
            "Venezuela",
            "Baraguá",
            "Primero de Enero",
            "Bolivia"
        ],
        "Camagüey": [
            "--Cualquiera--",
            "Camagüey",
            "Guáimaro",
            "Nuevitas",
            "Céspedes",
            "Jimaguayú",
            "Sibanicú",
            "Esmeralda",
            "Minas",
            "Sierra de Cubitas",
            "Florida",
            "Najasa",
            "Vertientes",
            "Santa Cruz del Sur"
        ],
        "Las Tunas": [
            "--Cualquiera--",
            "Manatí",
            "Puerto Padre",
            "Jesús Menéndez",
            "Majibacoa",
            "Las Tunas",
            "Jobabo",
            "Colombia",
            "Amancio"
        ],
        "Granma": [
            "--Cualquiera--",
            "Bartolomé Masó",
            "Bayamo",
            "Buey Arriba",
            "Campechuela",
            "Cauto Cristo",
            "Guisa",
            "Jiguaní",
            "Manzanillo",
            "Media Luna",
            "Niquero",
            "Pilón",
            "Río Cauto",
            "Yara"
        ],
        "Holguín": [
            "--Cualquiera--",
            "Antilla",
            "Báguanos",
            "Banes",
            "Cacocum",
            "Calixto García",
            "Cueto",
            "Frank País",
            "Gibara",
            "Holguín",
            "Mayarí",
            "Moa",
            "Rafael Freyre",
            "Sagüa de Tánamo",
            "Urbano Noris"
        ],
        "Santiago de Cuba": [
            "--Cualquiera--",
            "Contramaestre",
            "Guamá",
            "Mella",
            "Palma Soriano",
            "San Luis",
            "Santiago de Cuba",
            "Segundo Frente",
            "Songo-La Maya",
            "Tercer Frente"
        ],
        "Guantánamo": [
            "--Cualquiera--",
            "Baracoa",
            "Caimanera",
            "El Salvador",
            "Guantánamo",
            "Imías",
            "Maisí",
            "Manuel Tames",
            "Niceto Pérez",
            "San Antonio del Sur",
            "Yateras"
        ],
        "Isla de la Juventud": [
            "--Cualquiera--",
            "Nueva gerona"
        ]
    };
    
    final List<String> numbers = [
        "--Cualquiera--",
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
    ];
    
    final List<String> privinces = [
        "--Cualquiera--",
        "Pinar del Río",
        "Artemisa",
        "La Habana",
        "Mayabeque",
        "Matanzas",
        "Villa Clara",
        "Cienfuegos",
        "Sancti Spiritus",
        "Ciego de Ávila",
        "Camagüey",
        "Las Tunas",
        "Granma",
        "Holguín",
        "Santiago de Cuba",
        "Guantánamo",
        "Isla de la Juventud",
    ];
    
    List<String> cities = [
        "--Cualquiera--"
    ];
    
    final List<String> types = [
        "--Cualquiera--",
        "Casa",
        "Apartamento",
        "Terreno"
    ];
    
    String provinceValue = "--Cualquiera--";
    String cityValue = "--Cualquiera--";
    String typeValue = "--Cualquiera--";
    final minPriceController = TextEditingController();
    final maxPriceController = TextEditingController();
    String bedroomValue = "--Cualquiera--";
    String bathroomValue = "--Cualquiera--";
    
    String province;
    String city;
    String type;
    int minPrice;
    int maxPrice;
    int bedrooms;
    int bathrooms;
    
    bool isFiltered;
    
    bool isRetrying;
    
    @override
    void initState() {
        super.initState();
        setState(() {
            this.isFiltered = false;
            this.isRetrying = false;
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
                    if (isFiltered) {
                        clear();
                    } else {
                        showFormToSearch();
                    }
                },
                child: Icon(isFiltered ? Icons.close : Icons.filter_list),
                backgroundColor: Color(0xFF0069D9),
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
                                
//                                SchedulerBinding.instance.addPostFrameCallback((_) =>
//                                    setState(() {
//                                        this.isRetrying = false;
//                                    }));
                                
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
                                                .endsWith(
                                                this.province))
                                            .toList();
                                    }
                                    
                                    if (this.city != null) {
                                        homes = homes.where((home) =>
                                            home.location.trim()
                                                .startsWith(
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
                                    
                                    if (this.bedrooms != null) {
                                        homes = homes.where((home) =>
                                        home.bedroomsCount ==
                                            this.bedrooms)
                                            .toList();
                                    }
                                    
                                    if (this.bathrooms != null) {
                                        homes = homes.where((home) =>
                                        home.bathroomsCount ==
                                            this.bathrooms)
                                            .toList();
                                    }
                                    
                                    if (homes.isNotEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                            Toast.show(
                                                isFiltered
                                                    ? "${homes
                                                    .length} resultados para su búsquda."
                                                    : "${homes
                                                    .length} propiedades en oferta.",
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                        });
                                        
                                        return ListView.builder(
                                            itemCount: homes.length,
                                            itemBuilder: (context, index) {
                                                return HomeCard(
                                                    data: homes[index]);
                                            }
                                        );
                                    } else {
                                        return Center(
                                            child: Padding(
                                                padding: EdgeInsets.all(30),
                                                child: Text(
                                                    "No hay resultados."
                                                )
                                            ),
                                        );
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
                                                                .endsWith(
                                                                this.province))
                                                            .toList();
                                                    }
                                                    
                                                    if (this.city != null) {
                                                        homes = homes.where((
                                                            home) =>
                                                            home.location.trim()
                                                                .startsWith(
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
                                                    
                                                    if (this.bedrooms != null) {
                                                        homes = homes.where((
                                                            home) =>
                                                        home.bedroomsCount ==
                                                            this.bedrooms)
                                                            .toList();
                                                    }
                                                    
                                                    if (this.bathrooms !=
                                                        null) {
                                                        homes = homes.where((
                                                            home) =>
                                                        home.bathroomsCount ==
                                                            this.bathrooms)
                                                            .toList();
                                                    }
                                                    
                                                    if (homes.isNotEmpty) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback((
                                                            _) {
                                                            Toast.show(
                                                                isFiltered
                                                                    ? "${homes
                                                                    .length} resultados para su búsquda."
                                                                    : "${homes
                                                                    .length} propiedades en oferta.",
                                                                context,
                                                                duration: Toast
                                                                    .LENGTH_LONG,
                                                                gravity: Toast
                                                                    .BOTTOM);
                                                        });
                                                        
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
                                                        return Center(
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .all(30),
                                                                child: Text(
                                                                    "No hay resultados."
                                                                )
                                                            ),
                                                        );
                                                    }
                                                } else {
                                                    if (isRetrying) {
                                                        return Center(
                                                            child: CircularProgressIndicator()
                                                        );
                                                    }
                                                    
                                                    return Center(
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .all(30),
                                                            child: Text(
                                                                "No hay resultados."
                                                            )
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
    
    void showFormToSearch() {
        showGeneralDialog(
            context: context,
            barrierColor: Colors.black54,
            barrierDismissible: false,
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, __, ___) {
                return WillPopScope(
                    onWillPop: () async {
                        return Future.value(false);
                    },
                    child: GestureDetector(
                        onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Modal(
                            child: Scaffold(
                                body: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                        return Form(
                                            key: _formKey,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: <Widget>[
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xFFDC3545),
                                                        ),
                                                        padding: EdgeInsets
                                                            .only(
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
                                                                            .bold,
                                                                        color: Colors
                                                                            .white
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
                                                        child: ListView(
                                                            children: <Widget>[
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 20,
                                                                        vertical: 10
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisSize: MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                "Provincia",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFF0069D9),
                                                                                    fontSize: 12
                                                                                ),
                                                                            ),
                                                                            DropdownButton(
                                                                                isExpanded: true,
                                                                                value: provinceValue,
                                                                                onChanged: (
                                                                                    newValue) {
                                                                                    setState(() {
                                                                                        provinceValue =
                                                                                            newValue;
                                                                                        cityValue =
                                                                                        "--Cualquiera--";
                                                                                        if (newValue !=
                                                                                            "--Cualquiera--") {
                                                                                            cities =
                                                                                            location[newValue] as List<
                                                                                                String>;
                                                                                        }
                                                                                    });
                                                                                },
                                                                                items: privinces
                                                                                    .map((
                                                                                    type) {
                                                                                    return DropdownMenuItem(
                                                                                        child: new Text(
                                                                                            type),
                                                                                        value: type,
                                                                                    );
                                                                                })
                                                                                    .toList(),
                                                                            )
                                                                        ],
                                                                    )
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 20,
                                                                        vertical: 10
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisSize: MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                "Municipio",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFF0069D9),
                                                                                    fontSize: 12
                                                                                ),
                                                                            ),
                                                                            DropdownButton(
                                                                                isExpanded: true,
                                                                                value: cityValue,
                                                                                onChanged: (
                                                                                    newValue) {
                                                                                    setState(() {
                                                                                        cityValue =
                                                                                            newValue;
                                                                                    });
                                                                                },
                                                                                items: cities
                                                                                    .map((
                                                                                    type) {
                                                                                    return DropdownMenuItem(
                                                                                        child: new Text(
                                                                                            type),
                                                                                        value: type,
                                                                                    );
                                                                                })
                                                                                    .toList(),
                                                                            )
                                                                        ],
                                                                    )
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 20,
                                                                        vertical: 10
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisSize: MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                "Tipo",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFF0069D9),
                                                                                    fontSize: 12
                                                                                ),
                                                                            ),
                                                                            DropdownButton(
                                                                                isExpanded: true,
                                                                                value: typeValue,
                                                                                onChanged: (
                                                                                    newValue) {
                                                                                    setState(() {
                                                                                        typeValue =
                                                                                            newValue;
                                                                                    });
                                                                                },
                                                                                items: types
                                                                                    .map((
                                                                                    type) {
                                                                                    return DropdownMenuItem(
                                                                                        child: new Text(
                                                                                            type),
                                                                                        value: type,
                                                                                    );
                                                                                })
                                                                                    .toList(),
                                                                            )
                                                                        ],
                                                                    )
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 20,
                                                                        vertical: 10
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisSize: MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                "Precio mínimo",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFF0069D9),
                                                                                    fontSize: 12
                                                                                ),
                                                                            ),
                                                                            TextFormField(
                                                                                decoration: InputDecoration(
                                                                                    labelText: "--Cualquiera--",
                                                                                    contentPadding: EdgeInsets
                                                                                        .only(
                                                                                        top: 0,
                                                                                        bottom: 5),
                                                                                    hasFloatingPlaceholder: false,
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
                                                                            )
                                                                        ],
                                                                    )
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 20,
                                                                        vertical: 10
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisSize: MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                "Precio máximo",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFF0069D9),
                                                                                    fontSize: 12
                                                                                ),
                                                                            ),
                                                                            TextFormField(
                                                                                decoration: InputDecoration(
                                                                                    labelText: "--Cualquiera--",
                                                                                    contentPadding: EdgeInsets
                                                                                        .only(
                                                                                        top: 0,
                                                                                        bottom: 5),
                                                                                    hasFloatingPlaceholder: false,
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
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 20,
                                                                        vertical: 10
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisSize: MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                "Cuartos",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFF0069D9),
                                                                                    fontSize: 12
                                                                                ),
                                                                            ),
                                                                            DropdownButton(
                                                                                isExpanded: true,
                                                                                value: bedroomValue,
                                                                                onChanged: (
                                                                                    newValue) {
                                                                                    setState(() {
                                                                                        bedroomValue =
                                                                                            newValue;
                                                                                    });
                                                                                },
                                                                                items: numbers
                                                                                    .map((
                                                                                    type) {
                                                                                    return DropdownMenuItem(
                                                                                        child: new Text(
                                                                                            type),
                                                                                        value: type,
                                                                                    );
                                                                                })
                                                                                    .toList(),
                                                                            )
                                                                        ],
                                                                    )
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 20,
                                                                        vertical: 10
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisSize: MainAxisSize
                                                                            .min,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                "Baños",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFF0069D9),
                                                                                    fontSize: 12
                                                                                ),
                                                                            ),
                                                                            DropdownButton(
                                                                                isExpanded: true,
                                                                                value: bathroomValue,
                                                                                onChanged: (
                                                                                    newValue) {
                                                                                    setState(() {
                                                                                        bathroomValue =
                                                                                            newValue;
                                                                                    });
                                                                                },
                                                                                items: numbers
                                                                                    .map((
                                                                                    type) {
                                                                                    return DropdownMenuItem(
                                                                                        child: new Text(
                                                                                            type),
                                                                                        value: type,
                                                                                    );
                                                                                })
                                                                                    .toList(),
                                                                            )
                                                                        ],
                                                                    )
                                                                ),
                                                            ],
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
                                                                                "Cerrar",
                                                                                style: TextStyle(
                                                                                    color: Color(
                                                                                        0xFFDC3545)
                                                                                ),
                                                                            ),
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
                                                                            textColor: Color(
                                                                                0xFF0069D9),
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
                                        );
                                    }
                                )
                            )
                        )
                    )
                );
            }
        );
    }
    
    void close() {
        setState(() {
            this.provinceValue =
            (this.province != null) ? this.province : "--Cualquiera--";
            this.cityValue =
            (this.city != null) ? this.city : "--Cualquiera--";
            this.typeValue =
            (this.type != null) ? this.type : "--Cualquiera--";
            this.minPriceController.text =
            (this.minPrice != null) ? this.minPrice.toString() : "";
            this.maxPriceController.text =
            (this.maxPrice != null) ? this.maxPrice.toString() : "";
            this.bedroomValue =
            (this.bedrooms != null)
                ? this.bedrooms.toString()
                : "--Cualquiera--";
            this.bathroomValue =
            (this.bathrooms != null)
                ? this.bathrooms.toString()
                : "--Cualquiera--";
        });
    }
    
    void clear() {
        setState(() {
            this.isFiltered = false;
            this.province = null;
            this.city = null;
            this.type = null;
            this.minPrice = null;
            this.maxPrice = null;
            this.bedrooms = null;
            this.bathrooms = null;
        });
        close();
    }
    
    void search() {
        setState(() {
            this.isFiltered = true;
            if (this.provinceValue == "--Cualquiera--") {
                this.province = null;
            } else {
                this.province = this.provinceValue;
            }
            if (this.cityValue == "--Cualquiera--") {
                this.city = null;
            } else {
                this.city = this.cityValue;
            }
            if (this.typeValue == "--Cualquiera--") {
                this.type = null;
            } else {
                this.type = this.typeValue;
            }
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
            if (this.bedroomValue == "--Cualquiera--") {
                this.bedrooms = null;
            } else {
                this.bedrooms = int.parse(this.bedroomValue);
            }
            if (this.bathroomValue == "--Cualquiera--") {
                this.bathrooms = null;
            } else {
                this.bathrooms = int.parse(this.bathroomValue);
            }
        });
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
                                                        data.bedroomsCount > 0 ?
                                                        data.bedroomsCount
                                                            .toString() : "?",
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
                                                        data.bathroomsCount > 0
                                                            ?
                                                        data.bathroomsCount
                                                            .toString()
                                                            :
                                                        "?",
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

class Retry extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets
                .all(
                30),
            child: Row(
                mainAxisSize: MainAxisSize
                    .max,
                mainAxisAlignment: MainAxisAlignment
                    .center,
                children: <
                    Widget>[
                    Column(
                        mainAxisSize: MainAxisSize
                            .max,
                        mainAxisAlignment: MainAxisAlignment
                            .center,
                        children: <
                            Widget>[
                            Padding(
                                padding: EdgeInsets
                                    .only(
                                    bottom: 10),
                                child: Text(
                                    "Compruebe su conexión de red."
                                )
                            ),
                            RaisedButton(
                                child: Text(
                                    "Reintentar",
                                    style: TextStyle(
                                        color: Colors
                                            .white
                                    ),
                                ),
                                onPressed: () {
                                    blocs
                                        .homes();
                                },
                                color: Color(
                                    0xFF0069D9),
                            )
                        ],
                    )
                ],
            ),
        );
    }
}