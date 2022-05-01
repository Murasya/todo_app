import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../databases/todo_database.dart';

final todosProvider =
    StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());

class TodosNotifier extends StateNotifier<List<Todo>> {
  // Todo リストを空のリストとして初期化します。
  TodosNotifier() : super([]) {
    _todoDatabase = TodoDatabase();
    getTodos();
  }

  late final TodoDatabase _todoDatabase;

  // 全タスク取得
  void getTodos() async {
    final todos = await _todoDatabase.getTodos();
    state = todos;
  }

  // タスクの追加
  void addTodo(Todo todo) async {
    await _todoDatabase.insert(todo);
    state = [...state, todo];
  }

  // タスクの削除
  void removeTodo(String todoId) async {
    await _todoDatabase.delete(todoId);
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // タスクの完了ステータスの変更
  void changeStatus(Todo oldTodo, bool value) async {
    final newTodo = oldTodo.copyWith(status: value);
    await _todoDatabase.update(newTodo);
    state = [
      for (final todo in state)
        if (todo.id == newTodo.id) newTodo else todo,
    ];
  }

  // 日付超えてチェックついてたら外す
  void unsetStatus(List<Todo> todos) {
    DateTime now = DateTime.now();
    for (var todo in todos) {
      if (todo.deadline.isBefore(now)) {
        final newDeadline = now.add(Duration(days: todo.daysPerTask));
        final newTodo = todo.copyWith(deadline: newDeadline);
        changeStatus(newTodo, false);
      }
    }
    print("unset Status");
  }
}
