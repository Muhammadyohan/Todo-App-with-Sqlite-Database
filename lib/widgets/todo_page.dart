import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_using_prisma/bloc/bloc.dart';
import 'package:todo_app_using_prisma/widgets/widgets.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          return state is LoadingState
              ? const SizedBox(
                  height: 550,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : const TodoList();
        }),
        const TodoAdd(),
      ],
    );
  }
}
