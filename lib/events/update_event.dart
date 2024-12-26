import 'package:todolist/base/base_event.dart';
import 'package:todolist/models/todo.dart';

class UpdateEvent extends BaseEvent {

final Todo todo;
UpdateEvent({required this.todo}); 
}