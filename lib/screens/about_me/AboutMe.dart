import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatelessWidget {

  static Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: getAppBar(title: 'About Developer'),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          color: WHITE_COLOR,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenSize.width * 0.4,
                height: screenSize.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/images/keshav_garg.jpeg'))
                ),
              ),
              getAuthorTextWidget(label: ABOUT_DEVELOPER),
              getAuthorTextWidget(label: 'Know more about him!'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    iconSize: IconSize.MEDIUM,
                    onPressed: () async {
                      launch(SocialMediaLinks.LINKEDIN_PROFILE);
                    }),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.githubSquare),
                    iconSize: IconSize.MEDIUM,
                    onPressed: () async {
                      launch(SocialMediaLinks.GITHUB_PROFILE);
                    }),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.gitlab),
                    iconSize: IconSize.MEDIUM,
                    onPressed: () async {
                      launch(SocialMediaLinks.GITLAB_PROFILE);
                    }),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.internetExplorer),
                    iconSize: IconSize.MEDIUM,
                    onPressed: () async {
                      launch(SocialMediaLinks.PERSONAL_WEBSITE);
                    }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAuthorTextWidget({@required label}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(label,
        style: getTextStyleSettings(fontFamily: 'Comfortaa'),
        textAlign: TextAlign.justify),
    );
  }
}
