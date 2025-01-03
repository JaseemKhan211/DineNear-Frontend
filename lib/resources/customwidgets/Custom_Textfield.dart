import 'package:flutter/material.dart';
import 'package:dinenear_app/resources/colors/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../data/provider/location_provider.dart';
import '../../view/screens/Map_Places_Screen.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool readOnly;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputDecoration? decoration;
  const CustomTextField({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.fillColor,
    this.borderRadius = 20.0,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 5, horizontal: 15.0),
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onChanged,
    this.focusedBorder,
    this.enabledBorder,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onTap: onTap ?? () => handleMapSelection(context),
      onChanged: onChanged,
      decoration: decoration ??
      InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? AppColor.TextfieldColor,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(color: AppColor.textPrimaryColor),
        focusedBorder: focusedBorder ?? OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.TextfieldBorderColor)
        ),
        enabledBorder: enabledBorder ?? OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.TextfieldBorderColor)),
      ),
    );
  }

  Future<void> handleMapSelection(BuildContext context) async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPlacesScreen()),
    );
    if (selectedAddress != null) {
      List<Location> locations = await locationFromAddress(selectedAddress);
      Provider.of<LocationProvider>(context, listen: false).updateSelectedLocation(
        selectedAddress,
        locations.last.latitude,
        locations.last.longitude,
      );
    }
  }
}
