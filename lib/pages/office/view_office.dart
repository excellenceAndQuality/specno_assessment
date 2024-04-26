import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roy_specno_assessment/styles/custom_colors.dart';
import 'package:roy_specno_assessment/styles/strings.dart';
import 'package:roy_specno_assessment/widgets/add_new_staff_member_text_form_field.dart';
import 'package:roy_specno_assessment/widgets/global_elevated_button.dart';
import 'package:roy_specno_assessment/widgets/new_staff_member_avatar.dart';
import 'package:roy_specno_assessment/widgets/search_text_field.dart';

class OfficeView extends StatefulWidget {
  final String officeDocId;
  const OfficeView(this.officeDocId, {super.key});

  @override
  State<OfficeView> createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {

  final _formKey = GlobalKey<FormState>();
  late CollectionReference allOfficesRef;
  TextEditingController searchController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool _isExpanded = false;
  String selectedAvatarUrl = "", staffMemberDocId = "";
  late List<bool> ischecked;


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
        title: Text(Strings.office,
          style: const TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.black
          ),),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _officeDetails(context),
          const SizedBox(height: 20,),
          SearchTextField(controller: searchController),
            const SizedBox(height: 20,),
            Text(Strings.staffMembersInOffice,
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: CustomColors.text
              ),),
            const SizedBox(height: 20,),
            _fetchAllStaffMembers(context)
            
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.button,
        onPressed: (){
          _selectAvatarDialog(context);
        },
        child: const Icon(Icons.add, color: CustomColors.background, size: 28),
      ),
    );
  }

  Widget _officeDetails(BuildContext context){
    return StreamBuilder(
        stream: allOfficesRef.doc(widget.officeDocId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "Please wait...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.text),
              ),
            );
          }
          //snapshot.data['firstName']
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(int.parse(snapshot.data!['officeColorCode'])),),
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
                            snapshot.data!["officeName"],
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
                                          OfficeView(snapshot.data!["officeDocId"])),
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
                                    text: '${snapshot.data!["capacity"]} ',
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
                                Text(snapshot.data!["phoneNumber"],
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
                                Text(snapshot.data!["emailAddress"],
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
                                const Icon(Icons.person),
                                const SizedBox(width: 5,),
                                Text("Office Capacity: ${snapshot.data!["capacity"]}",
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
                                const Icon(Icons.location_on_rounded),
                                const SizedBox(width: 5,),
                                Text(snapshot.data!["physicalAddress"],
                                    style: const TextStyle(
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
          );
        });
  }

  Expanded _fetchAllStaffMembers(BuildContext context) {
    return Expanded(
        child: StreamBuilder(
            stream: allOfficesRef
                .doc(widget.officeDocId)
                .collection("staffMembers")
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
                      Center(
                        child: Text(
                          "Please wait...",
                          style: TextStyle(
                            fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              color: CustomColors.text),
                        ),
                      ),
                      Center(
                        child: Text(
                          "There are no staff members added.",
                          style: TextStyle(
                            fontFamily: "Inter",
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
                    "There are no staff members added.",
                    style: TextStyle(
                      fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: CustomColors.text),
                    textAlign: TextAlign.center,
                  ),
                );
              }//documents[index]["officeColorCode"]
              return ListView.builder(
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (context, index) => Container(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[400],
                              backgroundImage: NetworkImage(documents[index]["avatarUrl"],),
                            ),
                            Text("${documents[index]["firstName"]} ${documents[index]["lastName"]}",
                              style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black
                              ),
                            )
                          ],
                        ),
                        
                        const Icon(Icons.more_vert_rounded, color: Colors.black,)
                        
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }

  _addUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(10))),
          content: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: CustomColors.background
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.newStaffMember,
                          style: const TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.black
                          ),
                        ),
                        const Icon(Icons.close, color: Colors.black,)
                      ],
                    ),
                    const SizedBox(height: 30,),
                    AddNewStaffMemberTextFormField(controller: firstNameController, hint: "First Name"),
                    const SizedBox(height: 20,),
                    AddNewStaffMemberTextFormField(controller: lastNameController, hint: "Last Name"),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: CustomColors.blueButtonColour,
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                        const SizedBox(width: 2,),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(
                              color: CustomColors.blueButtonColour,
                              width: 4,
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    GlobalElevatedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            _selectAvatarDialog(context);

                          }

                        },
                        backgroundColor: CustomColors.blueButtonColour,
                        buttonText: "NEXT"),
                  ],
                )
              )),

        );
      },
    );
  }

  _selectAvatarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter){
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(10))),
                content: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: CustomColors.background
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.arrow_back, color: Colors.black,),
                                Text(Strings.newStaffMember,
                                  style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24,
                                      color: Colors.black
                                  ),
                                ),
                                const Icon(Icons.close, color: Colors.black,)
                              ],
                            ),
                            const SizedBox(height: 30,),
                            Text(Strings.avatar,
                              style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Colors.black
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(4, (index) {
                                return NewStaffMemberAvatar(
                                  isChecked: ischecked,
                                  onTap: () {
                                    setState(() {
                                      for (var i = 0; i < ischecked.length; i++) {
                                        ischecked[i] = i == index;
                                      }
                                    });
                                    getAvatarUrlCode(index + 1);
                                  },
                                  index: index + 1,
                                );
                              }),
                            ),
                            const SizedBox(height: 10),
                            // Second Row with 5 buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(3, (index) {
                                return NewStaffMemberAvatar(
                                  isChecked: ischecked,
                                  onTap: () {
                                    setState(() {
                                      for (var i = 0; i < ischecked.length; i++) {
                                        ischecked[i] = i == index + 4;
                                      }
                                    });
                                    getAvatarUrlCode(index + 5);
                                  },
                                  index: index + 5,
                                );
                              }),
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(80),
                                    border: Border.all(
                                      color: CustomColors.blueButtonColour,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2,),
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: CustomColors.blueButtonColour,
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            GlobalElevatedButton(
                                onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    _selectAvatarDialog(context);
                                  }
                                },
                                backgroundColor: CustomColors.blueButtonColour,
                                buttonText: "ADD STAFF MEMBER"),
                          ],
                        )
                    )),

              );
            });
      },
    );
  }

  void addStaffMemberToCloud(){
    staffMemberDocId = FirebaseFirestore.instance.collection("allOffices").doc().id;

    allOfficesRef.doc(widget.officeDocId).collection("staffMembers").doc(staffMemberDocId).set({
      'firstName': firstNameController.text.toString(),
      'lastName': lastNameController.text.toString(),
      'avatarUrl': selectedAvatarUrl.toString(),
      'capacity': 0,
      'createdAt': Timestamp.now(),
    }).whenComplete(() {
      allOfficesRef.doc(widget.officeDocId).update({
        'capacity': FieldValue.increment(1)
      }).whenComplete(() {

        Navigator.pop(context);

      });
    });

  }

  void getAvatarUrlCode(int index) {
    switch (index) {
      case 1:
        selectedAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_1.png?alt=media&token=1544cd25-3f5a-446d-8e9f-dfc6e14351a6";
        break;
      case 2:
        selectedAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_2.png?alt=media&token=628dfa42-1e0d-4dcc-b5e2-373edc4e9c9c";
        break;
      case 3:
        selectedAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_3.png?alt=media&token=681cc54e-8eb0-4705-ad90-1a3810adb24b";
        break;
      case 4:
        break;
        selectedAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_4.png?alt=media&token=3bf9fc89-8746-4bbe-9252-c702b94d25cf";
        break;
      case 5:
        selectedAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_5.png?alt=media&token=2d50713c-def8-4a60-9894-8fba667080a7";
        break;
      case 6:
        selectedAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_6.png?alt=media&token=5530b773-73dc-448c-9795-73b778b54be9";
        break;
      case 7:
        selectedAvatarUrl = "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_7.png?alt=media&token=12ddc964-1f57-4642-84e0-7c204595bb33";
        break;
      default:
        selectedAvatarUrl = "";

    }
  }

}
