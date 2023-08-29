import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppThemeState themeState;
  AppRouteState routeState;
  AppBloc(this.themeState, this.routeState)
      : super(AppState(themeState, routeState)) {
    on<EnableLightModeEvent>(_onEnableLightMode);
    on<EnableDarkModeEvent>(_onEnableDarkMode);
    on<HomeRouteEvent>(_onHomeRouteEvent);
    on<DetailsRouteEvent>(_onDetailsRouteEvent);
  }

  void _onEnableLightMode(EnableLightModeEvent event, Emitter<AppState> emit) {
    emit(LightModeState(AppThemeState.light));
  }

  void _onEnableDarkMode(EnableDarkModeEvent event, Emitter<AppState> emit) {
    emit(DarkModeState(AppThemeState.dark));
  }

  void _onHomeRouteEvent(HomeRouteEvent event, Emitter<AppState> emit) {
    emit(HomeRouteState(AppRouteState.home));
  }

  void _onDetailsRouteEvent(DetailsRouteEvent event, Emitter<AppState> emit) {
    emit(DetailsRouteState(AppRouteState.details));
  }
}
