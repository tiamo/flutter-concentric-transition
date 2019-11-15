import 'package:concentric_transition/page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PageData> _pages = [
      PageData(
        icon: Icons.fingerprint,
        header: "Online video courses\nfor scholars",
        //        title: "Step 2",
        content: "Get yourself ready\nfor final exams",
        //        textColor: Colors.black,
        bgColor: Color(0xFFFCE38A),
      ),
      PageData(
        icon: Icons.dashboard,
        header: "Webinars\nwith teachers",
        //        title: "Step 1",
        content: "Ask teachers anything you want\nin the chat",
        textColor: Colors.white,
        bgColor: Color(0xFFF38181),
      ),
      PageData(
        icon: Icons.device_hub,
        header: "Interactive\nHomework",
        // title: "Step 3",
        content: "Complete excercises, watch\nyour progress",
        //        textColor: Colors.black,
        bgColor: Color(0xFF95E1D3),
      ),
      PageData(
        icon: Icons.nfc,
        header: "Personal\nAssistant",
        // title: "Step 3",
        content:
            "Language learning school online distance education web tutorials",
        bgColor: Color(0xFFEAFFD0),
      ),
    ];

    List<Color> _colors = _pages.map((p) => p.bgColor).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ConcentricPageView(
          colors: _colors,
          //          itemCount: _pages.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (index, value) {
            PageData page = _pages[index % _pages.length];
            // For example scale or transform some widget by [value] param
            //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
            return Container(
              child: Theme(
                data: ThemeData(
                  iconTheme: IconThemeData(
                    color: page.bgColor.withGreen(170),
                  ),
                  textTheme: TextTheme(
                    headline: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                    title: TextStyle(
                      color: page.textColor,
                    ),
                    subtitle: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ),
                child: PageCard(page: page),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final PageData page;

  const PageCard({
    Key key,
    @required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
        //        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 150.0,
              bottom: 30.0,
            ),
            child: Text(
              page.header,
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Icon(
                    page.icon,
                    size: 150,
                    color: Colors.black12,
                  ),
                  bottom: -5,
                  left: 5,
                ),
                Icon(page.icon, size: 150),
              ],
            ),
          ),
          page.title != null
              ? Text(
                  page.title,
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center,
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(
              top: 5.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Text(
              page.content,
              style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PageData {
  final String header;
  final String title;
  final String content;
  final IconData icon;
  final Color bgColor;
  final Color textColor;

  PageData({
    this.header = "Concentric Onboarding",
    this.title,
    this.content,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}
