import 'package:sqflite/sqflite.dart';
import 'package:todo_app/databases/app_database.dart';
import '../models/todo.dart';

class TodoDatabase extends AppDatabase {
  final String _tableName = 'todos';

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );

    if (maps.isEmpty) return [];

    return maps.map((map) => Todo.fromMap(map)).toList();
  }

  Future<Todo> insert(Todo todo) async {
    final db = await database;

    await db.insert(
      _tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return todo.copyWith(
      id: todo.id,
    );
  }

  Future update(Todo todo) async {
    final db = await database;

    return await db.update(
      _tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future delete(String id) async {
    final db = await database;

    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}