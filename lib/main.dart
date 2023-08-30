import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/app/app.dart';
import 'package:travel_app/app/bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  runApp(const TravelApp());
}
