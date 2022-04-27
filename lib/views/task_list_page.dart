import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../viewModels/todo_view_model.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todosProvider);
    final todosNotifier = ref.watch(todosProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoリスト'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            Todo todo = todos[index];
            return CheckboxListTile(
              title: Text(todo.title),
              subtitle: Text(todo.daysPerTask.toString() + "日に1回 " + todo.deadline.toString()),
              value: todo.status,
              onChanged: (bool? isCheck) {
                todosNotifier.changeStatus(todo, isCheck!);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTodo');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
