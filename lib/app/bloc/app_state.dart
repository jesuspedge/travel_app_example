part of 'app_bloc.dart';

enum AppThemeState { light, dark }

enum AppRouteState { home, details }

final class AppState extends Equatable {
  AppThemeState themeState;
  AppRouteState appRouteState;

  AppState(this.themeState, this.appRouteState);

  @override
  List<Object> get props => [themeState, appRouteState];
}
