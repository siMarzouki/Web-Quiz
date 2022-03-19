import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../utils/images.dart';
import '../utils/strings.dart';
import '../utils/widgets.dart';

class RegisterScreen extends StatefulWidget {
  static String tag = '/RegisterScreen';

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode nameFocus = FocusNode();

  List<String> ageRangeList = [
    '5 - 10',
    '10 - 15',
    '15 - 20',
    '20 - 25',
    '25 - 30',
    '30 - 35',
    '35 - 40',
    '40 - 45',
    '45 - 50'
  ];

  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  signUp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);
      appStore.setLoading(true);

      await authService
          .signUpWithEmailPassword(
              name: nameController.text,
              email: emailController.text,
              password: passController.text.validate(),
              age: dropdownValue)
          .then((value) {
        appStore.setLoading(false);
        //DashboardScreen().launch(context, isNewTask: true);
        finish(context);
      }).catchError((e) {
        toast(e.toString());

        appStore.setLoading(false);
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: Image.asset(LoginPageImage,
                          height: context.height() * 0.35,
                          width: context.width(),
                          fit: BoxFit.fill),
                    ),
                    Positioned(
                      top: 30,
                      left: 16,
                      child: Image.asset(LoginPageLogo, width: 80, height: 80),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lbl_sign_up,
                              style: boldTextStyle(color: white, size: 30)),
                          8.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(lbl_already_have_an_account,
                                  style: primaryTextStyle(color: white)),
                              4.width,
                              Text(lbl_sign_in,
                                      style: boldTextStyle(color: white))
                                  .onTap(() {
                                finish(context);
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                30.height,
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lbl_name, style: primaryTextStyle()),
                      8.height,
                      AppTextField(
                        controller: nameController,
                        textFieldType: TextFieldType.NAME,
                        focus: nameFocus,
                        decoration: inputDecoration(hintText: lbl_name_hint),
                      ),
                      16.height,
                      Text(lbl_email_id, style: primaryTextStyle()),
                      8.height,
                      AppTextField(
                        controller: emailController,
                        textFieldType: TextFieldType.EMAIL,
                        focus: emailFocus,
                        nextFocus: passFocus,
                        decoration: inputDecoration(hintText: lbl_email_hint),
                      ),
                      16.height,
                      Text(lbl_password, style: primaryTextStyle()),
                      8.height,
                      AppTextField(
                        controller: passController,
                        focus: passFocus,
                        nextFocus: nameFocus,
                        textFieldType: TextFieldType.PASSWORD,
                        decoration: inputDecoration(
                          hintText: lbl_password_hint,
                        ),
                      ),
                      16.height,
                      Text(lbl_age, style: primaryTextStyle()),
                      8.height,
                      DropdownButtonFormField(
                        hint: Text('Select Age', style: secondaryTextStyle()),
                        value: dropdownValue,
                        decoration: inputDecoration(),
                        items: List.generate(
                          ageRangeList.length,
                          (index) {
                            return DropdownMenuItem(
                              value: ageRangeList[index],
                              child: Text('${ageRangeList[index]}',
                                  style: primaryTextStyle()),
                            );
                          },
                        ),
                        onChanged: (dynamic value) {
                          dropdownValue = value;
                        },
                        validator: (dynamic value) {
                          return value == null ? errorThisFieldRequired : null;
                        },
                      ),
                      30.height,
                      gradientButton(
                          text: lbl_sign_up,
                          onTap: signUp,
                          isFullWidth: true,
                          context: context),
                    ],
                  ).paddingOnly(left: 16, right: 16),
                ),
                16.height,
              ],
            ),
          ),
          Observer(builder: (context) => Loader().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
