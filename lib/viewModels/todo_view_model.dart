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

  void getTodos() async {
    final todos = await _todoDatabase.getTodos();
    state = todos;
  }

  // Todo の追加
  void addTodo(Todo todo) async {
    await _todoDatabase.insert(todo);
    state = [...state, todo];
  }

  // Todo の削除
  void removeTodo(String todoId) async {
    await _todoDatabase.delete(todoId);
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Todo の完了ステータスの変更
  void changeStatus(Todo oldTodo, bool value) async {
    final newTodo = oldTodo.copyWith(status: value);
    await _todoDatabase.update(newTodo);
    state = [
      for (final todo in state)
        if (todo.id == newTodo.id) newTodo else todo,
    ];
  }
}
