part of 'app_bloc.dart';

enum AppThemeState { light, dark }

enum AppRouteState { home, details }

@immutable
abstract class AppState extends Equatable {}

class LightModeState extends AppState {
  final AppThemeState _themeState;

  LightModeState(this._themeState);

  @override
  List<Object> get props => [_themeState];
}

class DarkModeState extends AppState {
  final AppThemeState _themeState;

  DarkModeState(this._themeState);

  @override
  List<Object> get props => [_themeState];
}

class HomeRouteState extends AppState {
  final AppRouteState _routeState;

  HomeRouteState(this._routeState);

  @override
  List<Object> get props => [_routeState];
}

class DetailsRouteState extends AppState {
  final AppRouteState _routeState;

  DetailsRouteState(this._routeState);

  @override
  List<Object> get props => [_routeState];
}
