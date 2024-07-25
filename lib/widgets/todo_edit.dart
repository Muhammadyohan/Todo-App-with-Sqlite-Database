import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_prisma/models/todo_model.dart';

import '../bloc/bloc.dart';

class TodoEditButton extends StatelessWidget {
  const TodoEditButton({
    super.key,
    required this.item,
  });

  final TodoModel item;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        showDialog(
          context: context,
          builder: (context) => EditDialog(item: item),
        );
      },
      child: const Text(
        'Edit',
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class EditDialog extends StatefulWidget {
  final TodoModel item;

  const EditDialog({super.key, required this.item});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _cycleDaysController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _cycleDaysController =
        TextEditingController(text: widget.item.cycleDays.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cycleDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _cycleDaysController,
            decoration: const InputDecoration(labelText: 'Cycle Days'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<TodoBloc>().add(EditEvent(
                id: widget.item.id,
                name: _nameController.text,
                cycleDays: int.parse(_cycleDaysController.text)));
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
