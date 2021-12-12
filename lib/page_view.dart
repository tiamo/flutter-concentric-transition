import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'clipper.dart';

class ConcentricPageView extends StatefulWidget {
  /// The [value] will help to provide some animations
  final Function(int index, double value) itemBuilder;
  final Function(int page)? onChange;
  final Function? onFinish;
  final int? itemCount;
  final PageController? pageController;
  final bool pageSnapping;
  final bool reverse;
  final List<Color> colors;
  final ValueNotifier? notifier;
  final double scaleFactor;
  final double opacityFactor;
  final double radius;
  final double verticalPosition;
  final Axis direction;
  final ScrollPhysics? physics;
  final Duration duration;
  final Curve curve;
  final Widget? buttonChild;

  const ConcentricPageView({
    Key? key,
    required this.itemBuilder,
    required this.colors,
    this.onChange,
    this.onFinish,
    this.itemCount,
    this.pageController,
    this.pageSnapping = true,
    this.reverse = false,
    this.notifier,
    this.scaleFactor = 0.3,
    this.opacityFactor = 0.0,
    this.radius = 40.0,
    this.verticalPosition = 0.75,
    this.direction = Axis.horizontal,
    this.physics,
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.easeOutSine, // Cubic(0.7, 0.5, 0.5, 0.1),
    this.buttonChild,
  })  : assert(colors.length >= 2),
        super(key: key);

  @override
  _ConcentricPageViewState createState() => _ConcentricPageViewState();
}

class _ConcentricPageViewState extends State<ConcentricPageView> {
  PageController? _pageController;

  double _progress = 0;
  int _prevPage = 0;
  Color? _prevColor;
  Color? _nextColor;

  @override
  void initState() {
    _prevColor = widget.colors[_prevPage];
    _nextColor = widget.colors[_prevPage + 1];
    _pageController = widget.pageController != null
        ? widget.pageController
        : PageController(
            initialPage: 0,
          );

    _pageController!.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.removeListener(_onScroll);
    if (widget.pageController == null) {
      _pageController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: _pageController!,
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
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
//            var i = index % widget.children.length;
            return AnimatedBuilder(
              animation: _pageController!,
              builder: (BuildContext context, child) {
                // on the first render, the pageController.page is null,
                // this is a dirty hack
                if (!_pageController!.position.hasContentDimensions) {
                  Future.delayed(Duration(microseconds: 1), () {
                    setState(() {});
                  });
                  return Container();
                }

                final double value = _pageController!.page! - index;
                final double scale =
                    (1 - (value.abs() * widget.scaleFactor)).clamp(0.0, 1.0);
                final double opacity =
                    (1 - (value.abs() * widget.opacityFactor)).clamp(0.0, 1.0);

                return Transform.scale(
                  scale: scale,
                  child: Opacity(
//                    duration: Duration(milliseconds: 1000),
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
    return RawMaterialButton(
      onPressed: () {
        if (_pageController!.page == widget.colors.length - 1) {
          if (widget.onFinish != null) {
            widget.onFinish!();
          }
        } else {
          _pageController!.nextPage(
            duration: widget.duration,
            curve: widget.curve,
          );
        }
      },
      constraints: BoxConstraints(
        minWidth: widget.radius * 2,
        minHeight: widget.radius * 2,
      ),
      shape: CircleBorder(),
      child: widget.buttonChild ?? SizedBox(),
    );
  }

  void _onPageChanged(int page) {
    if (widget.onChange != null) {
      widget.onChange!(page);
    }
  }

  void _onScroll() {
    ScrollDirection direction = _pageController!.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _prevPage = (_pageController!.page! + 0.001).toInt();
      _progress = _pageController!.page! - _prevPage;
//    } else if (direction == ScrollDirection.reverse) {
    } else {
      _prevPage = (_pageController!.page! - 0.001).toInt();
      _progress = _pageController!.page! - _prevPage;
//    } else {
//      _progress = 0;
    }

    final int total = widget.colors.length;
    int prevIndex = _prevPage % total;
    int nextIndex = prevIndex + 1;

    if (prevIndex == total - 1) {
      nextIndex = 0;
    }

    _prevColor = widget.colors[prevIndex];
    _nextColor = widget.colors[nextIndex];

    widget.notifier?.value = _pageController!.page! - _prevPage;
  }
}
