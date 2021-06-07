

import 'package:url_launcher/url_launcher.dart';

 launchURL(String link) async {
  String url = link;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw ' تعذر فتح $url';
  }
}