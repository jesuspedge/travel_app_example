part of 'app_bloc.dart';

enum AppThemeState { light, dark }

enum AppRouteState { home, details }

// ignore: must_be_immutable
final class AppState extends Equatable {
  AppThemeState themeState;
  AppRouteState appRouteState;

  AppState(
      {this.themeState = AppThemeState.light,
      this.appRouteState = AppRouteState.home});

  AppState copyWith({
    AppThemeState? themeState,
    AppRouteState? appRouteState,
  }) {
    return AppState(
        themeState: themeState ?? this.themeState,
        appRouteState: appRouteState ?? this.appRouteState);
  }

  @override
  List<Object> get props => [themeState, appRouteState];
}
