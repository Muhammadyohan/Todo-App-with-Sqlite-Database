import 'package:todo_app_using_prisma/_generated_prisma_client/prisma.dart';
import 'package:todo_app_using_prisma/models/repositories/todo_repository.dart';
import 'package:todo_app_using_prisma/models/todo_model.dart';
import 'package:todo_app_using_prisma/prisma.dart';
import 'package:orm/orm.dart';

class TodoRepositoryFromDatabase extends TodoRepository {
  late List<TodoModel> todoList = [];

  @override
  Future<List<TodoModel>> load() async {
    await Future.delayed(const Duration(milliseconds: 0));
    final todoListIt = await prisma.todoModel.findMany();
    todoList = todoListIt
        .map<TodoModel>((todo) => TodoModel.fromJson(todo.toJson()))
        .toList();
    return todoList;
  }

  @override
  Future<void> action({required int id}) async {
    final DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));
    await prisma.todoModel.update(
      where: TodoModelWhereUniqueInput(id: id),
      data: PrismaUnion.$1(
        TodoModelUpdateInput(
          lastTime: PrismaUnion.$1(now),
        ),
      ),
    );
  }

  @override
  Future<void> add({required String name, required int cycleDays}) async {
    await prisma.todoModel.create(
      data: PrismaUnion.$1(
        TodoModelCreateInput(
          name: name,
          cycleDays: cycleDays,
        ),
      ),
    );
  }

  @override
  Future<void> delete({required int id}) async {
    await prisma.todoModel.delete(where: TodoModelWhereUniqueInput(id: id));
  }

  @override
  Future<List<TodoModel>> search(String key) async {
    await Future.delayed(const Duration(seconds: 0));
    final filteredItems = todoList
        .where((item) => item.name.toLowerCase().contains(key.toLowerCase()))
        .toList();
    return filteredItems;
  }

  @override
  Future<void> update({
    required int id,
    required String name,
    required int cycleDays,
  }) async {
    await prisma.todoModel.update(
      where: TodoModelWhereUniqueInput(id: id),
      data: PrismaUnion.$1(
        TodoModelUpdateInput(
          name: PrismaUnion.$1(name),
          cycleDays: PrismaUnion.$1(cycleDays),
        ),
      ),
    );
  }
}
