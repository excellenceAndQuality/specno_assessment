import 'package:flutter/material.dart';
import 'package:roy_specno_assessment/styles/custom_colors.dart';
import 'package:roy_specno_assessment/widgets/text_field.dart';

import '../../styles/strings.dart';

class AddOffice extends StatefulWidget {
  const AddOffice({super.key});

  @override
  State<AddOffice> createState() => _AddOfficeState();
}

class _AddOfficeState extends State<AddOffice> {

  TextEditingController officeNameController = new TextEditingController();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(controller: officeNameController, hint: Strings.officeName,),
              const SizedBox(height: 10,),
              TextFieldWidget(controller: officeNameController, hint: Strings.physicalAddress),
              const SizedBox(height: 10,),
              TextFieldWidget(controller: officeNameController, hint: Strings.emailAddress),
              const SizedBox(height: 10,),
              TextFieldWidget(controller: officeNameController, hint: Strings.phoneNumber),
              const SizedBox(height: 10,),
              TextFieldWidget(controller: officeNameController, hint: Strings.maximumCapacity),
              const SizedBox(height: 20,),
              Text(Strings.officeColour,
                style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black
                ),),

            ],
          ),
        ),
      )
    );
  }
}
