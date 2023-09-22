import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app.dart';
import 'package:travel_app/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        JourneyModel lastJourney = context.read<AppBloc>().journeysList.last;

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  width: widget.size.width,
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
                          },
                          child: JourneyCard(
                              size: widget.size,
                              journey: journey,
                              last: journey == lastJourney ? true : false),
                        );
                      }),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: widget.size.width,
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
                    width: widget.size.width,
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
                            width: widget.size.width / 1.5,
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
