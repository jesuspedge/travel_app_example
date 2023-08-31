import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppThemeState themeState;
  AppRouteState routeState;
  List<JourneyModel> journeysList = List.unmodifiable(journeys);

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
