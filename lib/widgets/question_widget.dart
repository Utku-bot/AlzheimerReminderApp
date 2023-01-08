import 'package:flutter/material.dart';
import 'package:hatirla/utils/colors.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key, required this.question, required this.indexAction, required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Text("Soru ${indexAction + 1}/$totalQuestions :    $question",
        style: const TextStyle(fontSize: 24, color: neutral),),
    );
  }
}
