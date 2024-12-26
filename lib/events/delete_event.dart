import 'package:todolist/base/base_event.dart';
import 'package:todolist/models/todo.dart';

class DeleteEvent extends BaseEvent {

final Todo todo;
DeleteEvent({required this.todo}); 
}