import '../main.dart';
import '../models/CategoryModel.dart';
import './BaseService.dart';

class CategoryService extends BaseService {
  CategoryService() {
    ref = db.collection('categories');
  }

  Future<List<CategoryModel>> categories() async {
    return await ref.get().then((event) => event.docs
        .map((e) => CategoryModel.fromJson(e.data() as Map<String, dynamic>))
        .toList());
  }
}
