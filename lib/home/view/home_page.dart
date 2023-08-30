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
                    Icon(
                      Icons.search_rounded,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                    Text(
                      'Feed',
                      style: Theme.of(context).primaryTextTheme.headlineSmall,
                    ),
                    BlocBuilder<AppBloc, AppState>(
                      builder: (context, state) {
                        return GestureDetector(
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
