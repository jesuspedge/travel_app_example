part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class ChangeThemeEvent extends AppEvent {
  final AppThemeState themeState;
  const ChangeThemeEvent({required this.themeState});
}

final class ChangeRouteEvent extends AppEvent {
  final AppRouteState appRouteState;
  ChangeRouteEvent({required this.appRouteState});
}
