import 'package:dinenear_app/data/provider/location_provider.dart';
import 'package:dinenear_app/resources/colors/colors.dart';
import 'package:dinenear_app/resources/customwidgets/Custom_Button.dart';
import 'package:dinenear_app/resources/customwidgets/Custom_Textfield.dart';
import 'package:dinenear_app/resources/text%20styles/App_TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'Restraunts_Screen.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Your Location',style: AppTextStyles.AppbarStyle),
        flexibleSpace: Container(
        height: MediaQuery.of(context).size.height *0.1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[AppColor.AppbarColor1, AppColor.AppbarColor2]),
          ),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Google Map Widget
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                decoration: BoxDecoration(border: Border.all(color: AppColor.borderColor)),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: mapProvider.currentPosition,
                    zoom: 15.0,
                  ),
                  markers: mapProvider.markers,
                  compassEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    mapProvider.mapController = controller;
                    mapProvider.fetchCurrentLocation();
                  },
                ),
              ),
              // Current Address Input Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: CustomTextField(
                  controller: TextEditingController(text: mapProvider.currentAddress),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.TextfieldBorderColor)
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15.0),
                        prefixIcon: Icon(Icons.circle_outlined),
                        filled: true,
                        fillColor: AppColor.TextfieldColor,
                        hintStyle: TextStyle(color: AppColor.textPrimaryColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.TextfieldBorderColor),
                        ),
                      )
                ),
              ),
              // Search Radius Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //****yahan pr target location aygi****///
                child: CustomTextField(
                  controller: TextEditingController(text: context.watch<LocationProvider>().targetAddress),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.TextfieldBorderColor)
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15.0),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      hintText: "Target location",
                      fillColor: AppColor.TextfieldColor,
                      hintStyle: TextStyle(color: AppColor.textPrimaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.TextfieldBorderColor),
                      ),
                    ),
                  // //yahan logic di hai mene api uthane ki
                  // onTap: () => handleMapSelection(context),
                  // async{
                  //   final selectedAddress = await Navigator.push(context, MaterialPageRoute(builder: (context)=> MapPlacesScreen()));
                  //   if ( selectedAddress!= null) {
                  //     List<Location> locations = await locationFromAddress(selectedAddress);
                  //     Provider.of<LocationProvider>(context, listen: false).updateSelectedLocation(
                  //       selectedAddress,
                  //       locations.last.latitude,
                  //       locations.last.longitude,
                  //     );
                  //   }
                  // },
                ),
              ),
              // Find restraunt wala Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35,vertical: 15),
                child: CustomButton(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> RestrauntsScreen()));
                  },
                  color: AppColor.btnColor,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 17,
                  borderRadius: 5.0,
                  child: Text(
                    "Find Restaurant",style: AppTextStyles.BtnStyle,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
