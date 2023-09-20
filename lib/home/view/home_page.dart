import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app.dart';
import 'package:travel_app/details/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return PageRouteBuilder<void>(
        pageBuilder: (_, animation, __) =>
            FadeTransition(opacity: animation, child: const HomePage()));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        JourneyModel lastJourney = context.read<AppBloc>().journeysList.last;

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  width: size.width,
                  top: kToolbarHeight,
                  bottom: 0,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: context.read<AppBloc>().journeysList.length,
                      itemBuilder: (context, index) {
                        JourneyModel journey =
                            context.read<AppBloc>().journeysList[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<AppBloc>().add(ChangeRouteEvent(
                                appRouteState: AppRouteState.details,
                                journeySelected: index));
                            Navigator.push(context, DetailsPage.route(size));
                          },
                          child: JourneyCard(
                              size: size,
                              journey: journey,
                              last: journey == lastJourney ? true : false),
                        );
                      }),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: size.width,
                    height: kToolbarHeight,
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            color: Theme.of(context).primaryIconTheme.color,
                          ),
                          Text(
                            'Feed',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headlineSmall,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AppBloc>().add(
                                  state.themeState == AppThemeState.light
                                      ? const ChangeThemeEvent(
                                          themeState: AppThemeState.dark)
                                      : const ChangeThemeEvent(
                                          themeState: AppThemeState.light));
                            },
                            child: Icon(
                              state.themeState == AppThemeState.light
                                  ? CupertinoIcons.moon_stars_fill
                                  : CupertinoIcons.sun_min_fill,
                              color: Theme.of(context).primaryIconTheme.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: size.width,
                    height: kBottomNavigationBarHeight - 10,
                    child: CustomPaint(
                      painter: CustomBottomNavigationBar(
                          color: Theme.of(context).cardColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble,
                            color: Theme.of(context).primaryIconTheme.color,
                          ),
                          SizedBox(
                            width: size.width / 1.5,
                          ),
                          const Icon(
                            CupertinoIcons.square_split_2x2_fill,
                            color: Color(0xFF2F289E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xFF2F289E),
            splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
            child: const Icon(
              CupertinoIcons.location_solid,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

class JourneyCard extends StatelessWidget {
  const JourneyCard({
    super.key,
    required this.size,
    required this.journey,
    required this.last,
  });

  final Size size;
  final JourneyModel journey;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: last
          ? const EdgeInsets.fromLTRB(20, 10, 20, kBottomNavigationBarHeight)
          : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: size.height * 0.4,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(journey.pictures[0]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.softLight)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage(journey.user.profilePicture),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            journey.user.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            '${journey.createdAt.day}/${journey.createdAt.month}/${journey.createdAt.year} at ${journey.createdAt.hour}:${journey.createdAt.minute}.',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        CupertinoIcons.ellipsis,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const Spacer(flex: 2),
                  Text(
                    journey.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      journey.kind == KindJourney.popularPlaces
                          ? 'Popular Places'
                          : 'Events',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.heart,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        journey.numOfLikes.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        CupertinoIcons.arrowshape_turn_up_left,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        journey.numOfShares.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends CustomPainter {
  final Color color;

  CustomBottomNavigationBar({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final width25 = width * 0.25;
    final width5 = width * 0.5;
    final width75 = width * 0.75;
    final height75 = height * 0.75;

    final path = Path()
      ..lineTo(width25, 0)
      ..cubicTo((width25 + 50), 0, (width5 - 50), height75, width5, height75)
      ..cubicTo((width5 + 50), height75, (width75 - 50), 0, width75, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, 0);

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomBottomNavigationBar oldDelegate) => false;
}
