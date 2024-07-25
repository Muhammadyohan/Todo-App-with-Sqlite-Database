import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_prisma/bloc/bloc.dart';

class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  final TextEditingController _todoNameController = TextEditingController();
  final TextEditingController _todoCycleDaysController = TextEditingController();

  @override
  void dispose() {
    _todoNameController.dispose();
    _todoCycleDaysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: 250,
            child: Column(
              children: [
                _buildTextField(
                  controller: _todoNameController,
                  hintText: 'Todo Title',
                ),
                const SizedBox(height: 10,),
                _buildTextField(
                  controller: _todoCycleDaysController,
                  hintText: 'Cycle Days',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
          const SizedBox(width: 30,),
          ElevatedButton(
            onPressed: _addTodo,
            child: Text(
              'Add',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 44, 2, 116),
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 44, 2, 116),
            width: 3,
          ),
        ),
      ),
    );
  }

  void _addTodo() {
    String title = _todoNameController.text;
    int? cycleDays = int.tryParse(_todoCycleDaysController.text);
    if (title.isNotEmpty && cycleDays != null) {
      context.read<TodoBloc>().add(AddEvent(name: title, cycleDays: cycleDays));
      _todoNameController.clear();
      _todoCycleDaysController.clear();
    }
    FocusScope.of(context).unfocus();
  }
}
