import 'package:flutter/material.dart';

import '../styles/custom_colors.dart';


class NewStaffMemberAvatar extends StatelessWidget {
  final List<bool> isChecked;
  final VoidCallback onTap;
  final int index;

  const NewStaffMemberAvatar({
    Key? key,
    required this.isChecked,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(getImageByIndex(index)),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all( Radius.circular(50.0)),
          border: Border.all(
            color: isChecked[index - 1] ? CustomColors.officeColorActive : Colors.transparent,
            width: 4.0,
          ),
        ),
      ),
    );
  }

  String getImageByIndex(int index) {
    switch (index) {
      case 1:
        return "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_1.png?alt=media&token=1544cd25-3f5a-446d-8e9f-dfc6e14351a6";
      case 2:
        return "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_2.png?alt=media&token=628dfa42-1e0d-4dcc-b5e2-373edc4e9c9c";
      case 3:
        return "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_3.png?alt=media&token=681cc54e-8eb0-4705-ad90-1a3810adb24b";
      case 4:
        return "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_4.png?alt=media&token=3bf9fc89-8746-4bbe-9252-c702b94d25cf";
      case 5:
        return "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_5.png?alt=media&token=2d50713c-def8-4a60-9894-8fba667080a7";
      case 6:
        return "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_6.png?alt=media&token=5530b773-73dc-448c-9795-73b778b54be9";
      case 7:
        return "https://firebasestorage.googleapis.com/v0/b/specno-a5146.appspot.com/o/Avatars%2Fimg_7.png?alt=media&token=12ddc964-1f57-4642-84e0-7c204595bb33";
      default:
        return "";
    }
  }
}
