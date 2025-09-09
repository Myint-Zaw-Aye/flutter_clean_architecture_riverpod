import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture_riverpod/presentation/features/game/game_page.dart';
import 'package:clean_architecture_riverpod/presentation/home/detial_page.dart';
import 'package:clean_architecture_riverpod/presentation/home/home_page.dart';
import 'package:clean_architecture_riverpod/presentation/home/splash_page.dart';
import 'package:flutter/material.dart';
part 'app_route.gr.dart';
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter  {

  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc
      
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true), // use generated Route
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: DetialRoute.page,),
    AutoRoute(page: GameRoute.page,),
  ];
}
