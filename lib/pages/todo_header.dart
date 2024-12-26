import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/blocs/todo_bloc.dart';
import 'package:todolist/events/add_event.dart';
import 'package:todolist/models/todo.dart';

class ToDoHeader extends StatelessWidget {
  Widget build(BuildContext context) {
    var txtTodo = TextEditingController();

    var todoBloc = Provider.of<TodoBloc>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: txtTodo,
            decoration: const InputDecoration(
              hintText: 'Enter your todo',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            var newTodo = Todo(
              id: DateTime.now().millisecondsSinceEpoch,
              content: txtTodo.text,
              isDone: false,
            );
            todoBloc.dispatchEvent(AddEvent(todo: newTodo));

            txtTodo.clear();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
