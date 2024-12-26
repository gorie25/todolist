import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/pages/splash_screen.dart';
import 'package:todolist/pages/todo_container.dart';

class RouterConfigCustom {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            name: 'home',
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return TodoListContainer();
            },
          ),
        ],
      ),
    ],
  );
}