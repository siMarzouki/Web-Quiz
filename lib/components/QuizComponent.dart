import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../models/QuizModel.dart';
import '../utils/constants.dart';

class QuizComponent extends StatefulWidget {
  static String tag = '/QuizComponent';

  final QuizModel? quiz;

  QuizComponent({this.quiz});

  @override
  QuizComponentState createState() => QuizComponentState();
}

class QuizComponentState extends State<QuizComponent> {
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
    return Stack(
      children: [
        Container(
          width: (context.width() * 0.5) - 25,
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: BorderRadius.circular(defaultRadius),
            backgroundColor:
                widget.quiz!.minRequiredPoint! > getIntAsync(USER_POINTS)
                    ? Colors.grey.withOpacity(0.3)
                    : white,
            boxShadow: defaultBoxShadow(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 120,
                padding: EdgeInsets.all(5),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.quiz!.imageUrl!,
                      fit: BoxFit.fitHeight,
                      height: 120,
                      width: (context.width() * 0.5) - 25,
                    ).cornerRadiusWithClipRRectOnly(topLeft: 12, topRight: 12),
                    // Text(
                    //   widget.quiz!.quizTitle.validate(),
                    //   style: boldTextStyle(color: white),
                    //   maxLines: 4,
                    //   textAlign: TextAlign.start,
                    // ).paddingAll(16),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: radius(),
                        ),
                        child: Text('${widget.quiz!.questionRef!.length} Qs',
                            style:
                                primaryTextStyle(size: 12, color: Colors.white),
                            maxLines: 1),
                      ),
                    ),
                  ],
                ),
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.quiz!.quizTitle} ',
                      style: boldTextStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text('${widget.quiz!.minRequiredPoint!}',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ).paddingOnly(left: 16, right: 16),
              10.height,
            ],
          ),
        ),
        widget.quiz!.minRequiredPoint! > getIntAsync(USER_POINTS)
            ? Container(
                width: (context.width() - (3 * 16)) * 0.5,
                color: grey.withOpacity(0.3),
                height: 120,
              ).cornerRadiusWithClipRRectOnly(topLeft: 12, topRight: 12)
            : SizedBox(),
      ],
    );
  }
}
