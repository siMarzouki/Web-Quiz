import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quizapp_flutter/components/MoAzMarLogo.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class AboutUsScreen extends StatefulWidget {
  static String tag = '/AboutUsScreen';

  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
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
      appBar: appBarWidget('About',
          showBack: true, color: colorPrimary, textColor: white),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mAppName,
                style: TextStyle(
                    fontSize: 35.0,
                    letterSpacing: 2,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold)),
            16.height,
            Container(
              decoration:
                  BoxDecoration(color: colorPrimary, borderRadius: radius(4)),
              height: 4,
              width: 100,
            ),
            16.height,
            Text('version', style: secondaryTextStyle()),
            Text('1.0.0', style: primaryTextStyle()),
            Text(
              mAboutApp,
              style: primaryTextStyle(size: 14),
              textAlign: TextAlign.justify,
            ),
            16.height,
            Divider(),
            madeByMe
          ],
        ),
      ),
    );
  }
}
