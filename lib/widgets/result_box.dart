import 'package:flutter/material.dart';
import 'package:hatirla/utils/colors.dart';

class ResultBox extends StatelessWidget {
  final int result;
  final VoidCallback onPressed;
  final int questionLenght;

  const ResultBox(
      {Key? key, required this.result, required this.questionLenght,required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sonuç",
              style: TextStyle(color: neutral, fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundColor: result == questionLenght/2 ? Colors.yellow : result < questionLenght/2 ? incorrect : correct,
              child: Text(
                "$result/$questionLenght",
                style: TextStyle(fontSize: 30),
              ),
              radius: 70,
            ),
            const SizedBox(height: 20,),
            Text(result == questionLenght/2 ? "Nerdeyse Hepsi Doğru" : result < questionLenght/2 ? "Tekrar dene" : "Hepsi doğru",),
            const  SizedBox(height: 25 ,),
            GestureDetector(onTap: onPressed,child: const Text("Tekrar Başla",style: TextStyle(color: Colors.blue,fontSize : 20,letterSpacing: 1),),)
          ],
        ),
      ),
    );
  }
}
