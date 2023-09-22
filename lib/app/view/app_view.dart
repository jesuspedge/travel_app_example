import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/app.dart';
import 'package:travel_app/details/details.dart';
import 'package:travel_app/home/home.dart';
import 'package:travel_app/theme.dart';

class TravelApp extends StatelessWidget {
  const TravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => AppBloc(AppThemeState.light, AppRouteState.home))
    ], child: const TravelAppView());
  }
}

class TravelAppView extends StatefulWidget {
  const TravelAppView({Key? key}) : super(key: key);

  @override
  State<TravelAppView> createState() => _TravelAppViewState();
}

class _TravelAppViewState extends State<TravelAppView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          restorationScopeId: "root",
          debugShowCheckedModeBanner: false,
          theme:
              state.themeState == AppThemeState.light ? lightTheme : darkTheme,
          home: Navigator(
            pages: [
              MaterialPage(
                child: HomePage(size: MediaQuery.sizeOf(context)),
              ),
              if (state.appRouteState == AppRouteState.details)
                MaterialPage(
                  child: DetailsPage(size: MediaQuery.sizeOf(context)),
                )
            ],
            onPopPage: (route, result) {
              if (route.didPop(result)) return true;

              return false;
            },
          ),
        );
      },
    );
  }
}
