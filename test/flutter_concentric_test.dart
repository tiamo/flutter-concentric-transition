import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ConcentricPageView basic usage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ConcentricPageView(
          colors: const [Colors.white, Colors.amberAccent],
          itemBuilder: (index) => Center(child: Text('Page $index')),
        ),
      ),
    );
    await tester.pump(const Duration(microseconds: 200));
    expect(find.text('Page 0', skipOffstage: false), findsOneWidget);
  });

  testWidgets('ConcentricPageView controller', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    PageController controller = PageController(
      initialPage: 0,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ConcentricPageView(
          pageController: controller,
          colors: const [Colors.white, Colors.amberAccent],
          itemBuilder: (index) => Text('Page $index'),
        ),
      ),
    );
    await tester.pump(const Duration(microseconds: 100));
    expect(find.text('Page 0'), findsOneWidget);

    bool nextPageCompleted = false;
    controller
        .nextPage(
            duration: const Duration(milliseconds: 150), curve: Curves.ease)
        .then((_) => nextPageCompleted = true);

    expect(nextPageCompleted, false);
    await tester.pump(const Duration(milliseconds: 200));
    expect(nextPageCompleted, false);
    await tester.pump(const Duration(milliseconds: 200));
    expect(nextPageCompleted, true);

    expect(find.text('Page 1'), findsOneWidget);
  });

//  testWidgets('ConcentricPageView drag', (WidgetTester tester) async {
//    // ...
//  });
}
