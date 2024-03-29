import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../models/QuestionModel.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class QuizQuestionComponent extends StatefulWidget {
  static String tag = '/QuizQuestionComponent1';

  final QuestionModel? question;

  QuizQuestionComponent({this.question});

  @override
  QuizQuestionComponentState createState() => QuizQuestionComponentState();
}

class QuizQuestionComponentState extends State<QuizQuestionComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.question!.addQuestion}',
          style: boldTextStyle(size: 18),
        ),
        30.height,
        Column(
          children: List.generate(widget.question!.optionList!.length, (index) {
            String mData = widget.question!.optionList![index];
            return Container(
              padding: EdgeInsets.all(16),
              width: context.width(),
              margin: EdgeInsets.only(bottom: 16),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: widget.question!.selectedOptionIndex == index
                    ? colorPrimary.withOpacity(0.5)
                    : scaffoldColor,
              ),
              child: Text('$mData', style: primaryTextStyle()),
            ).onTap(() {
              setState(() {
                widget.question!.selectedOptionIndex = index;
                log(widget.question!.optionList![index]);
                widget.question!.answer = widget.question!.optionList![index];
                LiveStream().emit(answerQuestionStream, widget.question);
              });
            });
          }),
        ),
      ],
    );
  }
}
