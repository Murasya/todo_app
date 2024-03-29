import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/todo.dart';
import '../viewModels/todo_view_model.dart';

class AddTodoPage extends ConsumerWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String _title = "";
    int _daysPerTask = 1;
    final todosNotifier = ref.watch(todosProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo追加"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'タイトル',
              ),
              onChanged: (_text) {
                _title = _text;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "何日に一回行うか(数字で入力)",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_text) {
                _daysPerTask = int.parse(_text);
              },
            ),
            ElevatedButton(
              onPressed: () {
                todosNotifier.addTodo(Todo(
                  id: const Uuid().v4(),
                  title: _title,
                  status: false,
                  daysPerTask: _daysPerTask,
                  deadline: DateTime.now().add(Duration(days: _daysPerTask)),
                ));
                Navigator.pop(context);
              },
              child: const Text("追加"),
            ),
          ],
        ),
      ),
    );
  }
}
