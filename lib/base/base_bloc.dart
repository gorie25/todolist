import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todolist/base/base_event.dart';

abstract class BaseBloc {
  final StreamController<BaseEvent> _eventStreamController = StreamController<BaseEvent>();

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception('Event khong hop le');
      }
      dispatchEvent(event);
    });
  }

  Sink<BaseEvent> get event => _eventStreamController.sink;
  void dispatchEvent(BaseEvent event)
  {
          
  }

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
} 