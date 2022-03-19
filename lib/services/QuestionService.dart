import '../main.dart';
import '../models/QuestionModel.dart';
import './BaseService.dart';
import '../utils/ModelKeys.dart';

class QuestionService extends BaseService {
  QuestionService() {
    ref = db.collection('question');
  }

  Future<QuestionModel> questionById(String id) async {
    //return await ref.where('id', isEqualTo: id).limit(1).get().then((value) => QuestionModel.fromJson(value.docs.first.data()));
    return ref.where(CommonKeys.id, isEqualTo: id).limit(1).get().then((res) {
      if (res.docs.isNotEmpty) {
        return QuestionModel.fromJson(
            res.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'Not available';
      }
    });
  }

  Future<List<QuestionModel>> questionByCatId(String? catId) async {
    return await ref.where(QuestionKeys.category, isEqualTo: catId).get().then(
      (event) {
        return event.docs
            .map(
                (e) => QuestionModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      },
    );
  }
}
