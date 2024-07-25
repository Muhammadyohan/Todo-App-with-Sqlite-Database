import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class TodoActionButton extends StatelessWidget {
  const TodoActionButton({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      color: Colors.deepPurple,
      onPressed: () {
        FocusScope.of(context).unfocus();
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Are you sure you did the task?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  FocusScope.of(context).unfocus();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Confirm');
                  FocusScope.of(context).unfocus();
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 10, 160),
                  ),
                ),
              ),
            ],
          ),
        ).then((value) {
          if (value == 'Confirm') {
            context.read<TodoBloc>().add(TodoActionEvent(id: id));
          }
        });
      },
      icon: const Icon(Icons.check_circle),
    );
  }
}
