import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/blocs/todo_bloc.dart';
import 'package:todolist/events/delete_event.dart';
import 'package:todolist/events/update_event.dart';
import 'package:todolist/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  void initState() {
    super.initState();

    // Gọi loadStorage khi màn hình khởi động
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final todoBloc = Provider.of<TodoBloc>(context, listen: false);
      todoBloc.loadStorage(); // Tải dữ liệu từ SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    var todoBloc = Provider.of<TodoBloc>(context);
    return StreamBuilder<List<Todo>>(
      stream: todoBloc.todoListStream as Stream<List<Todo>>?,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Empty'));
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Empty'));
          } else {
            var todoList = snapshot.data!;
            return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                var todo = todoList[index];
                return ListTile(
                  title: Text(todo.content),
                  leading: null, // Không sử dụng leading ở đây
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, // Đảm bảo Row không chiếm toàn bộ không gian
                    children: [
                      Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          todoBloc.dispatchEvent(
                            UpdateEvent(todo: todo.copyWith(isDone: value)),
                          );
                          print(value);
                        },
                        activeColor: Colors.white, // Màu khi được chọn
                        checkColor: Colors.green, // Màu của dấu check
                      ),
                      GestureDetector(
                        onTap: () {
                          todoBloc.dispatchEvent(DeleteEvent(todo: todo));
                        },
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        } else {
          return Center(child: Text('No todos available'));
        }
      },
    );
  }
}
