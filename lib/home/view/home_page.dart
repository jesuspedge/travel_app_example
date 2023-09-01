import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
          backgroundColor: Theme.of(context).cardColor,
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
                      return JourneyCard(
                          size: size,
                          journey: journey,
                          last: journey == lastJourney ? true : false);
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
                          Icons.search_rounded,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        Text(
                          'Feed',
                          style:
                              Theme.of(context).primaryTextTheme.headlineSmall,
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
                                ? Icons.dark_mode_rounded
                                : Icons.light_mode_rounded,
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
                  height: kBottomNavigationBarHeight,
                  child: CustomPaint(
                    painter: CustomBottomNavigationBar(
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          )),
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
      child: Container(
        height: size.height * 0.4,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(journey.pictures[0]),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken)),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(journey.user.profilePicture),
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.short_text_rounded,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: journey.kind == KindJourney.popularPlaces
                        ? Colors.amber
                        : Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                    Icons.favorite_border_rounded,
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
                    Icons.share,
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
    final h5 = height * 0.5;
    final w25 = width * 0.25;
    final w5 = width * 0.5;
    final w75 = width * 0.75;
    final h75 = height * 0.75;

    final path = Path()
      ..lineTo(w25, 0)
      ..cubicTo((w5 - 40), 0, (w5 - 50), h5, w5, h75)
      ..cubicTo((w5 + 40), h75, (w5 + 50), 0, w75, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, 0);

    //canvas.drawShadow(path, Colors.black, 2, false);
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(CustomBottomNavigationBar oldDelegate) => false;
}
