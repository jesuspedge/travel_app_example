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
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          body: SafeArea(
              child: Stack(
            children: [
              Positioned(
                width: size.width,
                height: size.height - kToolbarHeight,
                top: kToolbarHeight,
                child: ListView.builder(
                    itemCount: context.read<AppBloc>().journeysList.length,
                    itemBuilder: (context, index) {
                      JourneyModel journey =
                          context.read<AppBloc>().journeysList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Container(
                          height: size.height * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(journey.pictures[0]),
                                fit: BoxFit.cover),
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
                                      backgroundImage: AssetImage(
                                          journey.user.profilePicture),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              color: Colors.white,
                                              fontSize: 13),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: journey.kind ==
                                              KindJourney.popularPlaces
                                          ? Colors.amber
                                          : Colors.green,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: size.width,
                  height: kToolbarHeight,
                  color: Theme.of(context).cardColor,
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
                child: Container(
                  width: size.width,
                  height: kBottomNavigationBarHeight,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
