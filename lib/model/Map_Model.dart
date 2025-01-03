class MapModel{
  final double radius;
  final String place;
  final double latitude;
  final double longitude;

  MapModel({
    required this.radius,
    required this.place,
    required this.latitude,
    required this.longitude
  });


  factory MapModel.fromJson(Map <String, dynamic> json){
    return MapModel(
        radius: json['radius'],
        place: json['place'],
        latitude: json['latitude'],
        longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'radius' : radius,
      'place' : place,
      'latitude' : latitude,
      'longitude' : longitude,
    };
  }
}