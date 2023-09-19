import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
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
    emit(state.copyWith(
        appRouteState: event.appRouteState,
        journeyListIndexSelected: event.journeySelected));
  }

  @override
  AppState fromJson(Map<String, dynamic> json) => AppState(
        themeState: AppThemeState.values.elementAt(json['themeState']),
        appRouteState: AppRouteState.values.elementAt(json['appRoute']),
        journeyListIndexSelected: json['indexJourneySelected'],
      );

  @override
  Map<String, int> toJson(AppState state) => {
        'themeState': state.themeState.index,
        'appRoute': state.appRouteState.index,
        'indexJourneySelected': state.journeyListIndexSelected,
      };
}
