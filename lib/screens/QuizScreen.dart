import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../components/QuizComponent.dart';
import '../models/QuizModel.dart';
import './QuizDescriptionScreen.dart';
import '../services/QuizService.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';

class QuizScreen extends StatefulWidget {
  static String tag = '/QuizScreen';

  final String? catName, catId;

  QuizScreen({this.catName, this.catId});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.catName}'),
        backgroundColor: colorPrimary,
      ),
      body: FutureBuilder<List<QuizModel>>(
        future: QuizService().getQuizByCatId(widget.catId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.sort((a, b) =>
                a.quizTitle!.length * 10 -
                b.quizTitle!.length * 10 +
                a.quizTitle!.compareTo(b.quizTitle ?? ""));
            return snapshot.data!.isNotEmpty
                ? SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Wrap(
                        runSpacing: 16,
                        spacing: 16,
                        children: snapshot.data!.map((mData) {
                          return QuizComponent(quiz: mData).onTap(() {
                            if (mData.questionRef.validate().isEmpty)
                              return toast('No question found');

                            if (mData.minRequiredPoint! <=
                                getIntAsync(USER_POINTS)) {
                              QuizDescriptionScreen(quizModel: mData)
                                  .launch(context);
                            } else {
                              toast(
                                  'Your Points:${getIntAsync(USER_POINTS)} \n minimum Required Points is ${mData.minRequiredPoint}');
                            }
                          });
                        }).toList(),
                      ),
                    ),
                  )
                : emptyWidget();
          }
          return snapWidgetHelper(snapshot,
              defaultErrorMessage: errorSomethingWentWrong);
        },
      ),
    );
  }
}
