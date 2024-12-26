import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/blocs/todo_bloc.dart';
import 'package:todolist/pages/splash_screen.dart';
import 'package:todolist/pages/todo_container.dart';
import 'package:todolist/routers/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF6200EE),
              title: const Text('Todo List'),
            ),
            body: Provider<TodoBloc>.value(
                value: TodoBloc(), child: MaterialApp.router(
      routerConfig: RouterConfigCustom.router,
    ))));
  }
}
