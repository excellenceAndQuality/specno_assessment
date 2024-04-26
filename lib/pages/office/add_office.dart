import 'package:flutter/material.dart';
import 'package:roy_specno_assessment/pages/landing_page.dart';
import 'package:roy_specno_assessment/styles/custom_colors.dart';
import 'package:roy_specno_assessment/widgets/text_form_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../styles/strings.dart';
import '../../widgets/office_colour_button.dart';

class AddOffice extends StatefulWidget {
  const AddOffice({super.key});

  @override
  State<AddOffice> createState() => _AddOfficeState();
}

class _AddOfficeState extends State<AddOffice> {

  final _formKey = GlobalKey<FormState>();
  late CollectionReference allOfficesRef;
  TextEditingController officeNameController = TextEditingController();
  TextEditingController physicalAddressController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController maximumCapacityController = TextEditingController();
  late List<bool> ischecked;
  String officeDocId = "", officeColorCode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ischecked = List<bool>.generate(11, (index) => false);

    allOfficesRef = FirebaseFirestore.instance.collection('allOffices');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: CustomColors.backButton, //change your color here
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: CustomColors.background,
        title: Text(Strings.newOffice,
        style: const TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 19, right: 19, top: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormFieldWidget(controller: officeNameController, hint: Strings.officeName),
                const SizedBox(height: 10,),
                TextFormFieldWidget(controller: physicalAddressController, hint: Strings.physicalAddress),
                const SizedBox(height: 10,),
                TextFormFieldWidget(controller: emailAddressController, hint: Strings.emailAddress),
                const SizedBox(height: 10,),
                TextFormFieldWidget(controller: phoneNumberController, hint: Strings.phoneNumber),
                const SizedBox(height: 10,),
                TextFormFieldWidget(controller: maximumCapacityController, hint: Strings.maximumCapacity),
                const SizedBox(height: 20,),
                Text(Strings.officeColour,
                  style: const TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.black
                  ),),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        addOfficeToCloud();

                      }

                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Colors.white,
                      backgroundColor: CustomColors.addOfficeColour,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      minimumSize: const Size(232, 48),
                    ),
                    child: Text(Strings.addOffice,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: "Inter"
                      ),),
                  ),
                )

              ],
            ),
          )
        ),
      )
    );
  }

  void addOfficeToCloud(){
    officeDocId = FirebaseFirestore.instance.collection("allOffices").doc().id;

    allOfficesRef.doc(officeDocId).set({
      'officeName': officeNameController.text.toString(),
      'physicalAddress': physicalAddressController.text.toString(),
      'emailAddress': emailAddressController.text.toString(),
      'phoneNumber': phoneNumberController.text.toString(),
      'maximumCapacity': maximumCapacityController.text.toString(),
      'officeColorCode': officeColorCode,
      'capacity': 0,
      'createdAt': Timestamp.now(),
    }).whenComplete(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
              (route) => false);
    });

  }

  void printColorCode(int index) {
    switch (index) {
      case 1:
        officeColorCode = "0xffffbe0b";
        print("Color Code: ${CustomColors.officeColor1.toString()}");
        break;
      case 2:
        officeColorCode = "0xffff9b71";
        print("Color Code: ${CustomColors.officeColor2}");
        break;
      case 3:
        officeColorCode = "0xfffb5607";
        print("Color Code: ${CustomColors.officeColor3}");
        break;
      case 4:
        officeColorCode = "0xff97512c";
        print("Color Code: ${CustomColors.officeColor4}");
        break;
      case 5:
        officeColorCode = "0xffdbbadd";
        print("Color Code: ${CustomColors.officeColor5}");
        break;
      case 6:
        officeColorCode = "0xffff006e";
        print("Color Code: ${CustomColors.officeColor6}");
        break;
      case 7:
        officeColorCode = "0xffa9f0d1";
        print("Color Code: ${CustomColors.officeColor7}");
        break;
      case 8:
        officeColorCode = "0xff00b402";
        print("Color Code: ${CustomColors.officeColor8}");
        break;
      case 9:
        officeColorCode = "0xff489dda";
        print("Color Code: ${CustomColors.officeColor9}");
        break;
      case 10:
        officeColorCode = "0xff0072e8";
        print("Color Code: ${CustomColors.officeColor10}");
        break;
      case 11:
        officeColorCode = "0xff8338ec";
        print("Color Code: ${CustomColors.officeColor11}");
        break;
      default:
        officeColorCode = "0xffff9b71";

    }
  }
}
