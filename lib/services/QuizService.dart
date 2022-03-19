import '../models/QuizModel.dart';
import './BaseService.dart';
import '../utils/ModelKeys.dart';

import '../main.dart';

class QuizService extends BaseService {
  QuizService() {
    ref = db.collection('quiz');
  }

  Future<List<QuizModel>> getQuizByCatId(String? id) async {
    var d = await ref.where(QuizKeys.categoryId, isEqualTo: id).get().then(
        (event) => event.docs
            .map((e) => QuizModel.fromJson(e.data() as Map<String, dynamic>))
            .toList());
    print(d);
    return d;
  }
}
