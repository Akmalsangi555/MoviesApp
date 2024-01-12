
import 'app_colors.dart';
import 'app_text_style.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  /// Creates a PrimaryButton.

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final String title;
  final VoidCallback onPressed;
  final bool enabled;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final IconData? icon;
  final bool isIcon;

  PrimaryButton({
    Key? key,
    this.margin,
    this.padding,
    required this.title,
    required this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    this.titleColor,
    this.height,
    this.width,
    this.fontSize,
    this.icon,
    this.isIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: enabled ? backgroundColor ?? AppColors.red : AppColors.grey,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: width ?? double.infinity,
            height: height ?? 35,
            alignment: Alignment.center,
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isIcon ? Icon(icon, color: AppColors.white) : SizedBox(),
                isIcon ? SizedBox(width: 11) : SizedBox(),
                Text(title, textAlign: TextAlign.center, style: AppTextStyle.boldWhite14,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
