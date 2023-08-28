part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent();
}

class EnableLightModeEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class EnableDarkModeEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class HomeRouteEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class DetailsRouteEvent extends AppEvent {
  @override
  List<Object> get props => [];
}
