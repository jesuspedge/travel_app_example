import 'dart:ui';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app.dart';
import 'package:travel_app/details/details.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //Controller to init the position when screen inits
  late ScrollController _scrollController;
  late ValueNotifier<double> _bottomPercenNotifier;

  void _scrollListener() {
    double percent = _scrollController.position.pixels / widget.size.height;
    _bottomPercenNotifier.value = lerpDouble(0.0, 1.0, (percent / 0.5))!;
  }

  @override
  void initState() {
    _scrollController =
        ScrollController(initialScrollOffset: widget.size.height * 0.4);
    _scrollController.addListener(_scrollListener);
    _bottomPercenNotifier = ValueNotifier(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        JourneyModel journey = context
            .read<AppBloc>()
            .journeysList
            .elementAt(state.journeyListIndexSelected);
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    SliverPersistentHeader(
                      delegate: MyPersistentHeaderDelegate(
                        maxExtent: widget.size.height,
                        minExtent: widget.size.height * 0.6,
                        builder: (percent) {
                          double topPercent =
                              ((1 - percent) / 0.6).clamp(0.0, 1.0);
                          double bottomPercent =
                              (percent / 0.4).clamp(0.0, 1.0);

                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned.fill(
                                //With top and bottom we create spaces to interact
                                top: (1 - bottomPercent) * 20,
                                bottom: 160 * (1 - bottomPercent),
                                child: Stack(
                                  children: [
                                    Transform.scale(
                                      scaleX: lerpDouble(1, 1.2, bottomPercent),
                                      child: JourneyPicturesWidget(
                                        journey: journey,
                                      ),
                                    ),
                                    Positioned(
                                      top: lerpDouble(widget.size.height * 0.65,
                                          15, topPercent),
                                      left: lerpDouble(-25, 20, bottomPercent),
                                      child: BlocBuilder<AppBloc, AppState>(
                                        builder: (context, state) {
                                          return GestureDetector(
                                            onTap: () {
                                              context.read<AppBloc>().add(
                                                  ChangeRouteEvent(
                                                      appRouteState:
                                                          AppRouteState.home,
                                                      journeySelected: 0));
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(
                                                Icons
                                                    .arrow_back_ios_new_rounded,
                                                color: Colors.white),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: lerpDouble(widget.size.height * 0.65,
                                          15, topPercent),
                                      right: lerpDouble(-25, 20, bottomPercent),
                                      child: const Icon(CupertinoIcons.ellipsis,
                                          color: Colors.white),
                                    ),
                                    Positioned(
                                      left: lerpDouble(150, 30, topPercent),
                                      top: lerpDouble(
                                          widget.size.height * 0.25,
                                          widget.size.height * 0.25,
                                          topPercent),
                                      child: Opacity(
                                        opacity: bottomPercent,
                                        child: Text(
                                          journey.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: lerpDouble(
                                                  30, 50, topPercent)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: lerpDouble(5, 30, topPercent),
                                      top: lerpDouble(
                                          widget.size.height * 0.8,
                                          widget.size.height * 0.32,
                                          topPercent),
                                      child: Opacity(
                                        opacity: _scrollController.offset <=
                                                widget.size.height * 0.4
                                            ? bottomPercent
                                            : lerpDouble(0.8, 1, topPercent)!,
                                        child: KindJourneyWidget(
                                          journey: journey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                top: _scrollController.offset <=
                                        widget.size.height * 0.4
                                    ? lerpDouble(
                                        widget.size.height * 0.85,
                                        widget.size.height * 0.46,
                                        bottomPercent)
                                    : lerpDouble(widget.size.height,
                                        widget.size.height * 0.47, topPercent),
                                child: TranslateAnimation(
                                  child: SocialInfoWidget(
                                    journey: journey,
                                    visible: _scrollController.offset <=
                                        widget.size.height * 0.47,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                top: lerpDouble(widget.size.height * 0.91,
                                    widget.size.height * 0.52, bottomPercent),
                                child: TranslateAnimation(
                                    child: JourneyUserWidget(
                                  journey: journey,
                                )),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TranslateAnimation(
                          child: DetailsJourneyWidget(
                            widget: widget,
                            journey: journey,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TranslateAnimation(
                          child: Container(
                            height: widget.size.height * 0.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder<double>(
                  valueListenable: _bottomPercenNotifier,
                  builder: (context, value, child) {
                    return Positioned.fill(
                      top: null,
                      bottom:
                          _scrollController.offset < widget.size.height * 0.4
                              ? lerpDouble(-widget.size.height * 0.1, 0, value)
                              : 0,
                      child: child!,
                    );
                  },
                  child: Container(
                    height: widget.size.height * 0.1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).primaryColor.withOpacity(0.8)
                        ],
                      ),
                    ),
                    child: FloatingBottomWidget(
                      journey: journey,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class TranslateAnimation extends StatelessWidget {
  const TranslateAnimation({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 100 * value),
          child: child,
        );
      },
      child: child,
    );
  }
}

class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MyPersistentHeaderDelegate(
      {required double maxExtent,
      required double minExtent,
      required this.builder})
      : _maxExtent = maxExtent,
        _minExtent = minExtent;

  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) builder;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
