import 'package:flutter/material.dart';
import 'package:todolist/pages/todo_list.dart';
import 'package:todolist/pages/todo_header.dart';

class TodoListContainer extends StatelessWidget {
  const TodoListContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ToDoHeader(),
                 Expanded(child:ToDoList()),
        ],
      ),
    );
  }
}
