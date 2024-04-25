import 'package:flutter/material.dart';

import '../styles/custom_colors.dart';


class OfficeColourButton extends StatelessWidget {
  final List<bool> isChecked;
  final VoidCallback onTap;
  final int colorIndex;

  const OfficeColourButton({
    Key? key,
    required this.isChecked,
    required this.onTap,
    required this.colorIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: getColorByIndex(colorIndex),
          borderRadius: BorderRadius.circular(80),
          border: Border.all(
            color: isChecked[colorIndex - 1] ? CustomColors.officeColorActive : Colors.transparent,
            width: 4,
          ),
        ),
      ),
    );
  }

  Color getColorByIndex(int index) {
    switch (index) {
      case 1:
        return CustomColors.officeColor1;
      case 2:
        return CustomColors.officeColor2;
      case 3:
        return CustomColors.officeColor3;
      case 4:
        return CustomColors.officeColor4;
      case 5:
        return CustomColors.officeColor5;
      case 6:
        return CustomColors.officeColor6;
      case 7:
        return CustomColors.officeColor7;
      case 8:
        return CustomColors.officeColor8;
      case 9:
        return CustomColors.officeColor9;
      case 10:
        return CustomColors.officeColor10;
      case 11:
        return CustomColors.officeColor11;
      default:
        return Colors.transparent;
    }
  }
}
