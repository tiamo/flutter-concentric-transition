# Concentric Transition

A Flutter plugin to create views using Concentric Transition Clipper. 
Useful for onboarding, page transitions, custom clippers, painters etc.

Inspired by [Cuberto - Animated Onboarding Screens](https://dribbble.com/shots/6654320-Animated-Onboarding-Screens)

[![Pub package](https://img.shields.io/pub/v/concentric_transition.svg)](https://pub.dartlang.org/packages/concentric_transition)
[![Build Status](https://travis-ci.org/tiamo/flutter_concentric_transition.svg?branch=master)](https://travis-ci.org/felangel/bloc)
[![Star on GitHub](https://img.shields.io/github/stars/tiamo/flutter_concentric_transition.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/tiamo/flutter_concentric_transition)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

## Getting Started
* Add this to your pubspec.yaml
  ```
  dependencies:
  concentric_transition: ^0.0.1
  ```
* Get the package from Pub:
  ```
  flutter packages get
  ```
* Import it in your file
  ```
  import 'package:concentric_transition/concentric_transition.dart';
  ```

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
 
 * Using ConcentricClipper widget
 ``` dart
 import 'package:concentric_transition/concentric_transition.dart';
 
 ClipPath(
   clipper: ConcentricClipper(
     progress: 0.1, // double
     reverse: false,
     radius: 30.0,
     verticalPosition: 0.82,
   ),
   child: Container(
     color: Colors.green,
   ),
 )
 ``` 
 
 * Check out the complete [Example](https://github.com/tiamo/concentric_swipe_flutter/tree/master/example)
 
## Roadmap
    
 * Page Route
 * Tests
 
## Credits

 * [Cuberto - Animated Onboarding Screens](https://dribbble.com/shots/6654320-Animated-Onboarding-Screens)

## Maintainers
 
 * [Vlad Korniienko](https://github.com/tiamo)
 
## License

 [![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)