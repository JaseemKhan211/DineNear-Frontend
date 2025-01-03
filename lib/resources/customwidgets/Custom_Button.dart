import 'package:dinenear_app/resources/colors/colors.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color borderColor;
  final Function()? onTap;
  final Widget? child;
  final double? height;
  final double width;
  final double borderRadius;

   CustomButton({
    this.title,
    this.color,
    this.textColor,
    this.textStyle,
    this.disabledColor,
    this.disabledTextColor,
    this.borderColor = AppColor.transparentColor,
    this.onTap,
    this.child,
    this.height,
    this.width = double.infinity,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      color: color,
      disabledColor: disabledColor,
      disabledTextColor: disabledTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(color: borderColor, width: 1),
      ),
      onPressed: onTap,
      child: child ??   Text(
        title ?? "",
        style: textStyle,
      ),
    );
  }
}
