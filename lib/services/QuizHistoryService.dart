import '../main.dart';
import '../models/QuizHistoryModel.dart';
import './BaseService.dart';
import '../utils/ModelKeys.dart';
import '../utils/constants.dart';

class QuizHistoryService extends BaseService {
  QuizHistoryService() {
    ref = db.collection('quizHistory');
  }

  Future<List<QuizHistoryModel>> quizHistoryByQuizType(
      {String? quizType}) async {
    if (quizType == All) {
      return await ref
          .where(QuizHistoryKeys.userId, isEqualTo: appStore.userId)
          .orderBy('createdAt', descending: true)
          .get()
          .then((value) => value.docs
              .map((e) =>
                  QuizHistoryModel.fromJson(e.data() as Map<String, dynamic>))
              .toList());
    }
    return await ref
        .where(QuizHistoryKeys.userId, isEqualTo: appStore.userId)
        .where(QuizHistoryKeys.quizType, isEqualTo: quizType)
        .orderBy(CommonKeys.createdAt, descending: true)
        .get()
        .then((value) => value.docs
            .map((e) =>
                QuizHistoryModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
  }
}
