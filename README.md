# Concentric Transition

A Flutter plugin to create views using Concentric Transition Clipper. 
Useful for onboarding, page transitions, custom clippers, painters etc.

Inspired by [Cuberto - Animated Onboarding Screens](https://dribbble.com/shots/6654320-Animated-Onboarding-Screens)

[![Build Status](https://github.com/tiamo/flutter-concentric-transition/actions/workflows/main.yml/badge.svg)](https://github.com/tiamo/flutter-concentric-transition)
[![Pub package](https://img.shields.io/pub/v/concentric_transition.svg)](https://pub.dartlang.org/packages/concentric_transition)
[![Star on GitHub](https://img.shields.io/github/stars/tiamo/flutter-concentric-transition.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/tiamo/flutter-concentric-transition)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

![1.gif](https://github.com/tiamo/flutter-concentric-transition/raw/master/screens/1.gif)
![2.gif](https://github.com/tiamo/flutter-concentric-transition/raw/master/screens/2.gif)
![3.gif](https://github.com/tiamo/flutter-concentric-transition/raw/master/screens/3.gif)
![4.gif](https://github.com/tiamo/flutter-concentric-transition/raw/master/screens/4.gif)
![5.gif](https://github.com/tiamo/flutter-concentric-transition/raw/master/screens/5.gif)
![6.gif](https://github.com/tiamo/flutter-concentric-transition/raw/master/screens/6.gif)

## Getting Started
* Add this to your pubspec.yaml
  ```
  dependencies:
  concentric_transition: ^1.0.1
  ```
* Get the package from Pub:
  ```
  flutter packages get
  ```
* Import it in your file
  ```
  import 'package:concentric_transition/concentric_transition.dart';
  ```
## Features

* Concentric PageView
* Concentric Clipper
* Concentric PageRoute

## Usage

 * Using ConcentricPageView widget
 ``` dart
 import 'package:concentric_transition/concentric_transition.dart';
 
 ConcentricPageView(
    colors: <Color>[Colors.white, Colors.blue, Colors.red],
    itemCount: 1, // null = infinity
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (int index, double value) {
        return Center(
            child: Container(
                child: Text('Page $index'),
            ),
        );
    },
 );
 ``` 
 
 * Using ConcentricPageRoute widget
 ``` dart
 Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
   return NextPage();
 }));
 ``` 
 
 * Using ConcentricClipper widget
 ``` dart
 import 'package:concentric_transition/concentric_transition.dart';
 
 ClipPath(
   clipper: ConcentricClipper(
     progress: 0.1, // from 0.0 to 1.0
     reverse: false,
     radius: 30.0,
     verticalPosition: 0.82,
   ),
   child: Container(
     color: Colors.green,
   ),
 )
 ``` 
 
 * Check out the complete [Example](https://github.com/tiamo/flutter-concentric-transition/tree/master/example)

## Credits

 * [Cuberto - Animated Onboarding Screens](https://dribbble.com/shots/6654320-Animated-Onboarding-Screens)

## Maintainers
 
 * [Vlad Korniienko](https://github.com/tiamo)
 
## License

 [![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)