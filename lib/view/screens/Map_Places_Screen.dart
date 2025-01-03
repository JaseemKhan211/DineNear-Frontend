import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
class MapPlacesScreen extends StatefulWidget {
  const MapPlacesScreen({super.key});

  @override
  State<MapPlacesScreen> createState() => _MapPlacesScreenState();
}

class _MapPlacesScreenState extends State<MapPlacesScreen> {
  TextEditingController _placecontroller = TextEditingController();
  var uuid = Uuid();
  String _sessiontoken = '1111';
  List<dynamic> _placelist = [];
  @override
  void initState() {
    super.initState();
  _placecontroller.addListener((){
    onChange();
  });
  }

  void onChange() {
    if(_sessiontoken == null){
      setState(() {
        _sessiontoken = uuid.v4();
      });
    }
    getSuggestion (_placecontroller.text);
  }


  void getSuggestion(String input) async {
    //ye api key
  const String PLACE_API = "AIzaSyBlxJRveTb3NQJ4NM7IUEr-f6va5NwQBWU";
    // API URL for place api then isme concat krna h take logic me request use kri jaske
  final String apiUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = '$apiUrl?input=$input&key=$PLACE_API&sessiontoken=$_sessiontoken';

  var response = await http.get(Uri.parse(request));
  var data = response.body.toString();
  print(response.body.toString());
  if(response.statusCode == 200){
    setState(() {
      _placelist= jsonDecode(response.body.toString())['predictions'];
    });
  } else{
    throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
                TextFormField(
                  controller: _placecontroller,
                  decoration: InputDecoration(hintText: 'search'),
                ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _placelist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                        title: Text(_placelist[index]['description']),
                        // onTap: ()async{
                        //     List<Location> locations = await locationFromAddress(_placelist[index]['description']);
                        //     print(locations.last.latitude);
                        //     print(locations.last.longitude);
                        //     },
                          onTap: () async {
                            List<Location> locations = await locationFromAddress(_placelist[index]['description']);
                            Navigator.pop(context, _placelist[index]['description']);
                          },

                        );
                      },
                  )),
            ],
          ),
        ),
    );
  }


}
