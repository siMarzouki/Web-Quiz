import 'package:nb_utils/nb_utils.dart';
import '../models/Model.dart';
import '../screens/AboutUsScreen.dart';
import '../screens/EarnPointScreen.dart';
import '../screens/MyQuizHistoryScreen.dart';
import '../screens/ProfileScreen.dart';
import '../screens/QuizCategoryScreen.dart';
import '../screens/SelfChallengeFormScreen.dart';
import './constants.dart';
import './images.dart';
import './strings.dart';

String description =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";

List<DrawerItemModel> getDrawerItems() {
  List<DrawerItemModel> drawerItems = [];
  drawerItems.add(DrawerItemModel(name: lbl_home, image: HomeImage));
  drawerItems.add(DrawerItemModel(
      name: lbl_profile, image: ProfileImage, widget: ProfileScreen()));
  drawerItems.add(DrawerItemModel(
      name: lbl_quiz_category,
      image: QuizCategoryImage,
      widget: QuizCategoryScreen()));
  drawerItems.add(DrawerItemModel(
      name: lbl_self_challenge,
      image: SelfChallengeImage,
      widget: SelfChallengeFormScreen()));
  drawerItems.add(DrawerItemModel(
      name: lbl_my_quiz_history,
      image: QuizHistoryImage,
      widget: MyQuizHistoryScreen()));
  if (!getBoolAsync(DISABLE_AD))
    drawerItems.add(DrawerItemModel(
        name: lbl_earn_points,
        image: EarnPointsImage,
        widget: EarnPointScreen()));
  drawerItems.add(DrawerItemModel(
      name: lbl_about_us, image: AboutUsImage, widget: AboutUsScreen()));
  drawerItems.add(DrawerItemModel(name: lbl_rate_us, image: RateUsImage));
  drawerItems.add(DrawerItemModel(name: lbl_logout, image: LogoutImage));
  return drawerItems;
}
