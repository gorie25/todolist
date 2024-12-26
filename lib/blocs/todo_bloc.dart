import 'dart:async';
import 'package:todolist/base/base_bloc.dart';
import 'package:todolist/base/base_event.dart';
import 'package:todolist/events/add_event.dart';
import 'package:todolist/events/delete_event.dart';
import 'package:todolist/events/update_event.dart';
import 'package:todolist/models/todo.dart';
import'package:shared_preferences/shared_preferences.dart'; 
class TodoBloc extends BaseBloc {

  StreamController<List<Todo>> _todoListStreamController = StreamController<List<Todo>>();
  List<Todo> _todoList =  []; 


Stream get todoListStream => _todoListStreamController.stream;
Future<void> _saveTodosToStorage() async {
  final prefs = await SharedPreferences.getInstance();

  // Tách danh sách _todoList thành id và content
  final ids = _todoList.map((todo) => todo.id.toString()).toList();
  final contents = _todoList.map((todo) => todo.content).toList();
  final isDones = _todoList.map((todo) => todo.isDone.toString()).toList();

  // Lưu vào SharedPreferences
  await prefs.setStringList('todo_ids', ids);        // Lưu danh sách id
  await prefs.setStringList('todo_contents', contents); // Lưu danh sách nội dung
  await prefs.setStringList('todo_isDones', isDones); // Lưu danh sách nội dung
}


// Hàm tải danh sách từ SharedPreferences
  Future<void> loadStorage() async {
    final prefs = await SharedPreferences.getInstance();

    // Lấy danh sách id và content từ SharedPreferences
    final ids = prefs.getStringList('todo_ids') ?? [];
    final contents = prefs.getStringList('todo_contents') ?? [];
    final isDones = prefs.getStringList('todo_isDones') ?? [];

    // Chuyển đổi id và content thành danh sách Todo
    _todoList = List.generate(ids.length, (index) {
      return Todo(
        id: int.parse(ids[index]),
        content: contents[index],
        isDone: isDones[index].toString().toLowerCase() == 'true',
      );
    });

    // Phát danh sách qua Stream
    _todoListStreamController.sink.add(_todoList);
  }



  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent

    if(event is AddEvent){
      print(event.todo.content);
      _todoList.add(event.todo);
      _saveTodosToStorage();
      _todoListStreamController.sink.add(_todoList);
    } else if (event is DeleteEvent){
      _todoList.remove(event.todo);
      _saveTodosToStorage();
      _todoListStreamController.sink.add(_todoList);  
    }
    else if(event is UpdateEvent){
      int index = _todoList.indexWhere((todo) => todo.id == event.todo.id);
      if (index != -1) {
        _todoList[index] = event.todo;
      _saveTodosToStorage();
      _todoListStreamController.sink.add(_todoList);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}}