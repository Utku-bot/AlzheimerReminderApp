import 'package:flutter/material.dart';
import 'package:hatirla/utils/colors.dart';

class NextQuestion extends StatelessWidget {
  const NextQuestion({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Text("Sonraki Soru",textAlign: TextAlign.center,),


    );
  }
}
