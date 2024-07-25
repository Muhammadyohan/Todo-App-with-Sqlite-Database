import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_prisma/bloc/bloc.dart';
import 'package:todo_app_using_prisma/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'widgets.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select((TodoBloc bloc) => bloc.state.items);
    return LimitedBox(
      maxHeight: 550,
      child: items.isEmpty
          ? SizedBox(
              height: 550,
              width: double.infinity,
              child: Text(
                'Nothing to show.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (items[index].lastTime != null) {
                  return TodoCardWithLastTime(item: items[index]);
                } else {
                  return TodoCardWithoutLastTime(item: items[index]);
                }
              }),
    );
  }
}

class TodoCardWithoutLastTime extends StatelessWidget {
  const TodoCardWithoutLastTime({
    super.key,
    required this.item,
  });

  final TodoModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Card(
          color: const Color.fromARGB(255, 213, 189, 255),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
            bottom: 5,
          ),
          child: ListTile(
            leading: TodoActionButton(
              id: item.id,
            ),
            title: Text(item.name,
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(
              '${item.cycleDays} days left to do.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TodoEditButton(item: item),
                TodoDeleteButton(id: item.id),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TodoCardWithLastTime extends StatelessWidget {
  const TodoCardWithLastTime({
    super.key,
    required this.item,
  });

  final TodoModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Card(
          color: const Color.fromARGB(255, 213, 189, 255),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 5,
            bottom: 5,
          ),
          child: ListTile(
            leading: TodoActionButton(
              id: item.id,
            ),
            title: Text(item.name,
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item.cycleDays} days left to do.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Last time: ${DateFormat('yyyy-MM-dd - kk:mm').format(item.lastTime!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TodoEditButton(item: item),
                TodoDeleteButton(id: item.id),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
