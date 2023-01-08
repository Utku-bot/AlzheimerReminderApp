import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hatirla/read_data/get_user_data.dart';

import '../utils/colors.dart';

class UserDataPage extends StatelessWidget {
  const UserDataPage({Key? key, required this.docId}) : super(key: key);
  final String docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: myColorScaffold,
          centerTitle: true,
          title: Text("Kullanıcı Bilgileri"),
        ),
        body: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ClipPath(
                  clipper: CurvedBottomClipper(),
                  child: Container(
                    color: myColorScaffold,
                    height: 100,
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.face_outlined,
                    color: myColorScaffold,
                    size: 50,
                  ),
                ),

              ],
            ),
            GetUserData(documentId: docId)
          ],
        ));
  }
}
// Center(child: GetUserData(documentId: docId,)),

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 3 / 5;

    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    final roundingRectangle = Rect.fromLTRB(
        -5, size.height - roundingHeight * 2, size.width + 5, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
