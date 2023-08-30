import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppThemeState themeState;
  AppRouteState routeState;
  AppBloc(this.themeState, this.routeState)
      : super(AppState(themeState: themeState, appRouteState: routeState)) {
    on<ChangeThemeEvent>(_onThemeChange);
    on<ChangeRouteEvent>(_onRouteChange);
  }

  void _onThemeChange(ChangeThemeEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(themeState: event.themeState));
  }

  void _onRouteChange(ChangeRouteEvent event, Emitter<AppState> emit) {
    emit(state.copyWith(appRouteState: event.appRouteState));
  }
}
