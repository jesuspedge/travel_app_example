part of 'app_bloc.dart';

enum AppThemeState { light, dark }

enum AppRouteState { home, details }

// ignore: must_be_immutable
final class AppState extends Equatable {
  AppThemeState themeState;
  AppRouteState appRouteState;
  int journeyListIndexSelected;

  AppState(
      {this.themeState = AppThemeState.light,
      this.appRouteState = AppRouteState.home,
      this.journeyListIndexSelected = 0});

  AppState copyWith({
    AppThemeState? themeState,
    AppRouteState? appRouteState,
    int? journeyListIndexSelected,
  }) {
    return AppState(
      themeState: themeState ?? this.themeState,
      appRouteState: appRouteState ?? this.appRouteState,
      journeyListIndexSelected:
          journeyListIndexSelected ?? this.journeyListIndexSelected,
    );
  }

  @override
  List<Object> get props =>
      [themeState, appRouteState, journeyListIndexSelected];
}
