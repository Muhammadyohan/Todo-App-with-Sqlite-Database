import 'package:todo_app_using_prisma/models/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> load();
  Future<List<TodoModel>> search(String key);
  Future<void> add({required String name, required int cycleDays});
  Future<void> delete({required int id,});
  Future<void> update({required int id, required String name, required int cycleDays});
  Future<void> action({required int id});
}