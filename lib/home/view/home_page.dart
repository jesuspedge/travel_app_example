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

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.lightBlue,
              ),
            ),
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
                    const Icon(Icons.search_rounded),
                    BlocBuilder<AppBloc, AppState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<AppBloc>().add(state is HomeRouteState
                                ? DetailsRouteEvent()
                                : HomeRouteEvent());
                          },
                          child: Icon(state is HomeRouteState
                              ? Icons.exit_to_app
                              : Icons.home),
                        );
                      },
                    ),
                    const Text('Feed'),
                    BlocBuilder<AppBloc, AppState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context.read<AppBloc>().add(state is LightModeState
                                ? EnableDarkModeEvent()
                                : EnableLightModeEvent());
                          },
                          child: Icon(state is LightModeState
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded),
                        );
                      },
                    )
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
  }
}
