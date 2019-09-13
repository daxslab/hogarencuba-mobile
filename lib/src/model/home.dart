class HomeEntity {
    final String code;
    final String title;
    final int bedroomsCount;
    final int bathroomsCount;
    final int garageCount;
    final String metadata;
    final String description;
    final String location;
    final int price;
    final int ranking;
    final int createdAt;
    final String firstImageUrl;
    final String type;

    HomeEntity({this.code, this.title, this.bedroomsCount, this.bathroomsCount,
        this.garageCount, this.metadata, this.description,
        this.location, this.price, this.ranking, this.createdAt, this.firstImageUrl,
        this.type});
    
    factory HomeEntity.fromJson(Map<String, dynamic> json){
        return HomeEntity(
            code: json['code'],
            title: json['title'],
            bedroomsCount: json['bedroomsCount'],
            bathroomsCount: json['bathroomsCount'],
            garageCount: json['garageCount'],
            metadata: json['metadata'],
            description: json['description'],
            location: json['location'],
            price: json['price'],
            ranking: json['ranking'],
            createdAt: json['created_at'],
            firstImageUrl: json['firstImageUrl'],
            type: json['type']
        );
    }
}