import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'clipper.dart';

class ConcentricPageView extends StatefulWidget {
  /// The [value] will help to provide some animations
  final Function(int index, double value) itemBuilder;
  final int itemCount;
  final PageController pageController;
  final bool pageSnapping;
  final bool reverse;
  final List<Color> colors;
  final ValueNotifier notifier;
  final double scaleFactor;
  final double opacityFactor;
  final double radius;
  final double verticalPosition;
  final Axis direction;
  final ScrollPhysics physics;
  final Duration duration;
  final Curve curve;

  const ConcentricPageView({
    Key key,
    @required this.itemBuilder,
    this.itemCount,
    this.pageController,
    this.pageSnapping = true,
    this.reverse = false,
    this.colors = const [],
    this.notifier,
    this.scaleFactor = 0.3,
    this.opacityFactor = 1.0,
    this.radius = 30.0,
    this.verticalPosition = 0.8,
    this.direction = Axis.horizontal,
//    this.physics = const NeverScrollableScrollPhysics(),
    this.physics,
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeOutSine, // Cubic(0.7, 0.5, 0.5, 0.1),
  })  : assert(itemBuilder != null),
        super(key: key);

  @override
  _ConcentricPageViewState createState() => _ConcentricPageViewState();
}

class _ConcentricPageViewState extends State<ConcentricPageView> {
  PageController _pageController;

  double _progress = 0;
  int _prevPage = 0;
  Color _prevColor;
  Color _nextColor;

  @override
  void initState() {
    _prevColor = widget.colors[_prevPage];
    _nextColor = widget.colors[_prevPage + 1];
    _pageController = widget.pageController != null
        ? widget.pageController
        : PageController(
            initialPage: 0,
          );

    _pageController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    if (widget.pageController == null) {
      _pageController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: _pageController,
          builder: (ctx, _) {
            return Container(
              color: _prevColor, // Colors.white,
              child: ClipPath(
                clipper: ConcentricClipper(
                  progress: _progress,
                  reverse: widget.reverse,
                  radius: widget.radius,
                  verticalPosition: widget.verticalPosition,
                ),
                child: Container(
                  color: _nextColor,
//                  color: ColorTween(begin: _prevColor, end: _nextColor)
//                      .transform(_progress), // Colors.blue,
                ),
              ),
            );
          },
        ),
        PageView.builder(
          //          onPageChanged: (page) {
          //            print('new page $page');
          //          },
          controller: _pageController,
          reverse: widget.reverse,
          physics: widget.physics,
          scrollDirection: widget.direction,
          itemCount: widget.itemCount,
          pageSnapping: widget.pageSnapping,
          itemBuilder: (context, index) {
//            var i = index % widget.children.length;
            return AnimatedBuilder(
              animation: _pageController,
              builder: (BuildContext context, child) {
                // on the first render, the pageController.page is null,
                // this is a dirty hack
                if (_pageController.position.minScrollExtent == null ||
                    _pageController.position.maxScrollExtent == null) {
                  Future.delayed(Duration(microseconds: 1), () {
                    setState(() {});
                  });
                  return Container();
                }
                double value = _pageController.page - index;
                double scale =
                    (1 - (value.abs() * widget.scaleFactor)).clamp(0.0, 1.0);
                double opacity = widget.opacityFactor >= 1.0
                    ? widget.opacityFactor
                    : (1 - (value.abs() * widget.opacityFactor))
                        .clamp(0.0, 1.0);
                return Transform.scale(
                  scale: scale,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 1000),
                    opacity: opacity,
                    child: widget.itemBuilder(index, value),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * widget.verticalPosition,
          child: _buildButton(),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return InkWell(
      onTap: () {
        _pageController.nextPage(
          duration: widget.duration,
          curve: widget.curve,
        );
      },
      child: Container(
        width: widget.radius * 2,
        height: widget.radius * 2,
        decoration: BoxDecoration(
//          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        //          iconData,
        //          color: Colors.black,
        //        ),
//        child: Icon(
//          Icons.arrow_forward_ios,
//          color: Colors.white,
//        ),
      ),
    );
  }

  void _onScroll() {
    ScrollDirection direction = _pageController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _prevPage = (_pageController.page + 0.001).toInt();
      _progress = _pageController.page - _prevPage;
//    } else if (direction == ScrollDirection.reverse) {
    } else {
      _prevPage = (_pageController.page - 0.001).toInt();
      _progress = _pageController.page - _prevPage;
//    } else {
//      _progress = 0;
    }

    int total = widget.colors.length;
    int prevIndex = _prevPage % total;
    int nextIndex = prevIndex + 1;
    if (prevIndex == total - 1) {
      nextIndex = 0;
    }

    _prevColor = widget.colors[prevIndex];
    _nextColor = widget.colors[nextIndex];

    widget.notifier?.value = _pageController.page - _prevPage;
  }
}
