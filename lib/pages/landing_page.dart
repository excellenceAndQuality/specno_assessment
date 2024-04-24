import 'package:flutter/material.dart';
import 'package:roy_specno_assessment/pages/office/add_office.dart';
import 'package:roy_specno_assessment/styles/custom_colors.dart';
import 'package:roy_specno_assessment/styles/strings.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 80),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(Strings.allOffices,
                style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: CustomColors.text
                ),)
            ],

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.button,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddOffice(),
          ));
        },
        child: const Icon(Icons.add, color: CustomColors.background, size: 28),
      ),
    );
  }
}
