import 'package:todolist/base/base_event.dart';
import 'package:todolist/models/todo.dart';

class AddEvent extends BaseEvent {

final Todo todo;
  AddEvent({required this.todo}); 
}