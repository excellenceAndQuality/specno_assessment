import 'package:flutter/material.dart';
import 'package:roy_specno_assessment/widgets/office_colour_button.dart';

import '../styles/custom_colors.dart';

class MyRadioButton extends StatefulWidget {
  const MyRadioButton({Key? key}) : super(key: key);

  @override
  State<MyRadioButton> createState() => _MyRadioButtonState();
}

class _MyRadioButtonState extends State<MyRadioButton> {

  var ischecked = List<bool>.generate(11, (index) => index == 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First Row with 6 buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(6, (index) {
              return OfficeColourButton(
                isChecked: ischecked,
                onTap: () {
                  setState(() {
                    for (var i = 0; i < ischecked.length; i++) {
                      ischecked[i] = i == index;
                    }
                  });
                  printColorCode(index + 1);
                },
                colorIndex: index + 1,
              );
            }),
          ),
          SizedBox(height: 20),
          // Second Row with 5 buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              return OfficeColourButton(
                isChecked: ischecked,
                onTap: () {
                  setState(() {
                    for (var i = 0; i < ischecked.length; i++) {
                      ischecked[i] = i == index + 6;
                    }
                  });
                  printColorCode(index + 7);
                },
                colorIndex: index + 7,
              );
            }),
          ),
        ],
      ),
    );
  }

  void printColorCode(int index) {
    switch (index) {
      case 1:
        print("Color Code: ${CustomColors.officeColor1}");
        break;
      case 2:
        print("Color Code: ${CustomColors.officeColor2}");
        break;
      case 3:
        print("Color Code: ${CustomColors.officeColor3}");
        break;
      case 4:
        print("Color Code: ${CustomColors.officeColor4}");
        break;
      case 5:
        print("Color Code: ${CustomColors.officeColor5}");
        break;
      case 6:
        print("Color Code: ${CustomColors.officeColor6}");
        break;
      case 7:
        print("Color Code: ${CustomColors.officeColor7}");
        break;
      case 8:
        print("Color Code: ${CustomColors.officeColor8}");
        break;
      case 9:
        print("Color Code: ${CustomColors.officeColor9}");
        break;
      case 10:
        print("Color Code: ${CustomColors.officeColor10}");
        break;
      case 11:
        print("Color Code: ${CustomColors.officeColor11}");
        break;
      default:
        print("Color Code: Unknown");
    }
  }
}
