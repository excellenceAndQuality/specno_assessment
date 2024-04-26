import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:roy_specno_assessment/pages/office/add_office.dart';
import 'package:roy_specno_assessment/pages/office/view_office.dart';
import 'package:roy_specno_assessment/styles/custom_colors.dart';
import 'package:roy_specno_assessment/styles/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roy_specno_assessment/widgets/new_staff_member_avatar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late CollectionReference allOfficesRef;
  bool _isExpanded = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    allOfficesRef = FirebaseFirestore.instance.collection('allOffices');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 80),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(Strings.allOffices,
                style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: CustomColors.text
                ),),
              const SizedBox(height: 10,),
              _fetchAllOffices(context),

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

  Expanded _fetchAllOffices(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: allOfficesRef
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SpinKitFadingCircle(
                        color: CustomColors.button,
                        size: 20.0,
                      ),
                    ),
                    Center(
                      child: Text(
                        "There is no data available.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.text),
                      ),
                    ),
                  ],
                ),
              );
            }
            //documents[index]["docId"],
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return const Center(
                child: Text(
                  "There is no data available.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.text),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) => Container(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(int.parse(documents[index]["officeColorCode"])),),
                  child: Wrap(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  documents[index]["officeName"],
                                  style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w800,
                                      color: CustomColors.text,
                                      fontSize: 24),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OfficeView(documents[index]["officeDocId"])),
                                            (route) => true);

                                  },
                                  child: const Icon(Icons.edit),
                                )

                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 5,),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '${documents[index]["capacity"]} ',
                                          style: const TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                              color: CustomColors.text,
                                              fontSize: 12)),
                                      const TextSpan(
                                        text: 'Staff Members in Office',
                                        style: TextStyle(
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w400,
                                            color: CustomColors.text,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )


                              ],
                            ),
                            const Divider(
                                color: CustomColors.dividerColour
                            ),

                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("More info",
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.text,
                                        fontSize: 12),),
                                  Icon(_isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ),

                            if (_isExpanded)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.phone),
                                      const SizedBox(width: 5,),
                                      Text(documents[index]["phoneNumber"],
                                          style: const TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400,
                                              color: CustomColors.text,
                                              fontSize: 12)
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const Icon(Icons.email),
                                      const SizedBox(width: 5,),
                                      Text(documents[index]["emailAddress"],
                                          style: const TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400,
                                              color: CustomColors.text,
                                              fontSize: 12)
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children:  [
                                      Icon(Icons.person),
                                      SizedBox(width: 5,),
                                      Text("Office Capacity: ${documents[index]["capacity"]}",
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400,
                                              color: CustomColors.text,
                                              fontSize: 12)
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children:  [
                                      Icon(Icons.location_on_rounded),
                                      SizedBox(width: 5,),
                                      Text(documents[index]["physicalAddress"],
                                          style: TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w400,
                                              color: CustomColors.text,
                                              fontSize: 12)
                                      )
                                    ],
                                  ),
                                ],
                              ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
    );
  }

}
