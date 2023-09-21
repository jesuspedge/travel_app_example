import 'dart:ui';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app.dart';

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

class JourneyPicturesWidget extends StatefulWidget {
  const JourneyPicturesWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

  @override
  State<JourneyPicturesWidget> createState() => _JourneyPicturesWidgetState();
}

class _JourneyPicturesWidgetState extends State<JourneyPicturesWidget> {
  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.journey.pictures.length,
              onPageChanged: (value) {
                setState(() {
                  imageIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.journey.pictures[index]),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.journey.pictures.length,
              (index) => Container(
                color: imageIndex == index
                    ? Theme.of(context).primaryIconTheme.color
                    : Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 3,
                width: imageIndex == index ? 25 : 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class KindJourneyWidget extends StatelessWidget {
  const KindJourneyWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          gradient: journey.kind == KindJourney.popularPlaces
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.amber.shade300,
                    Colors.amber.shade700,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.green.shade300,
                    Colors.green.shade700,
                  ],
                ),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(
        journey.kind == KindJourney.popularPlaces ? 'Popular Places' : 'Events',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}

class JourneyUserWidget extends StatelessWidget {
  const JourneyUserWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(journey.user.profilePicture),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    journey.user.name,
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  Text(
                    '${journey.createdAt.day}/${journey.createdAt.month}/${journey.createdAt.year} at ${journey.createdAt.hour}:${journey.createdAt.minute}.',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.add,
                    color: Colors.grey,
                    size: 13,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Follow',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.7), fontSize: 15),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SocialInfoWidget extends StatelessWidget {
  const SocialInfoWidget({
    super.key,
    required this.journey,
    required this.visible,
  });

  final JourneyModel journey;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Visibility(
        visible: visible,
        child: Row(
          children: [
            Icon(
              CupertinoIcons.heart,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            const SizedBox(width: 10),
            Text(
              journey.numOfLikes.toString(),
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
            const SizedBox(width: 20),
            Icon(
              CupertinoIcons.arrowshape_turn_up_left,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            const SizedBox(width: 10),
            Text(
              journey.numOfShares.toString(),
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFBEEEFD),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(7),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.checkmark_alt_circle,
                    color: Colors.blue.shade400,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Check In',
                    style: TextStyle(
                        color: Colors.blue.shade300,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailsJourneyWidget extends StatelessWidget {
  const DetailsJourneyWidget({
    super.key,
    required this.widget,
    required this.journey,
  });

  final DetailsPage widget;
  final JourneyModel journey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.location_solid,
              color: Colors.grey.withOpacity(0.7),
            ),
            const SizedBox(width: 5),
            Text(
              'YUCATÁN, México',
              style: TextStyle(
                  color: Colors.blue.shade200,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.size.height * 0.22,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              journey.description,
              style: Theme.of(context).primaryTextTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'PLACES IN THIS COLLECTION',
            style: Theme.of(context).primaryTextTheme.labelLarge,
          ),
        ),
        SizedBox(
          height: widget.size.height * 0.15,
          child: ListView.separated(
            itemCount: journey.placesInCollection.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: ((context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(journey.placesInCollection[index]),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15)),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class FloatingBottomWidget extends StatelessWidget {
  const FloatingBottomWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

  @override
  Widget build(BuildContext context) {
    var comments = journey.comments.sublist(0, 3);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xFF2F289E),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Stack(
                    children: List.generate(comments.length, (index) {
                      return Positioned(
                        left: index * 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundImage: AssetImage(
                                journey.comments[index].profilePicture),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Comments',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(width: 10),
                Text(
                  journey.comments.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward,
                  color: Color.fromARGB(255, 16, 14, 54),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.blue.shade400,
                  ),
                ),
              ))
        ],
      ),
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
