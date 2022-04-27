import 'package:flutter/foundation.dart';

@immutable
class Todo {
  final String id;
  final String title;
  final bool status;
  final int daysPerTask;
  final DateTime deadline;

  const Todo(
      {required this.id,
      required this.title,
      required this.status,
      required this.daysPerTask,
      required this.deadline});

  Todo copyWith({
    String? id,
    String? title,
    bool? status,
    int? daysPerTask,
    DateTime? deadline,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      daysPerTask: daysPerTask ?? this.daysPerTask,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'status': bool2int(status),
      'days_per_task': daysPerTask,
      'deadline': deadline.toIso8601String(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    bool s;
    if (map['status'] == 1) {
      s = true;
    } else {
      s = false;
    }
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      status: s,
      daysPerTask: map['days_per_task'] as int,
      deadline: DateTime.parse(map['deadline'] as String),
    );
  }

  int bool2int(bool status) {
    if (status) {
      return 1;
    } else {
      return 0;
    }
  }
}
