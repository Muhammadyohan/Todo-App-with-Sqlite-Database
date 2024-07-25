import 'package:bloc/bloc.dart';
import 'package:todo_app_using_prisma/bloc/bloc.dart';
import 'package:todo_app_using_prisma/models/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  TodoBloc({required this.repository}) : super(LoadingState()) {
    on<LoadEvent>(_onLoaded);
    on<AddEvent>(_onAdded);
    on<DeleteEvent>(_onDeleted);
    on<EditEvent>(_onEdited);
    on<TodoActionEvent>(_onActionChecked);
    on<SearchEvent>(_onSearched);
    on<SearchClearEvent>(_onSearchCleared);
  }

  _onLoaded(LoadEvent event, Emitter<TodoState> emit) async {
    if (state is LoadingState) {
      final items = await repository.load();
      items.sort((a, b) => a.cycleDays.compareTo(b.cycleDays));
      emit(ReadyState(items: items));
    }
  }

  _onAdded(AddEvent event, Emitter<TodoState> emit) async {
    if (state is ReadyState || state is SearchState) {
      await repository.add(name: event.name, cycleDays: event.cycleDays);
      emit(LoadingState());
      add(LoadEvent());
    }
  }

  _onDeleted(DeleteEvent event, Emitter<TodoState> emit) async {
    if (state is ReadyState || state is SearchState) {
      await repository.delete(id: event.id);
      emit(LoadingState());
      add(LoadEvent());
    }
  }

  _onEdited(EditEvent event, Emitter<TodoState> emit) async {
    if (state is ReadyState || state is SearchState) {
      await repository.update(id: event.id, name: event.name, cycleDays: event.cycleDays);
      emit(LoadingState());
      add(LoadEvent());
    }
  }

  _onActionChecked(TodoActionEvent event, Emitter<TodoState> emit) async {
    if (state is ReadyState || state is SearchState) {
      await repository.action(id: event.id);
      emit(LoadingState());
      add(LoadEvent());
    }
  }

  _onSearched(SearchEvent event, Emitter<TodoState> emit) async {
    final filteredItems = await repository.search(event.key);
    emit(SearchState(items: filteredItems));
  }

  _onSearchCleared(SearchClearEvent event, Emitter<TodoState> emit) {
    emit(LoadingState());
    add(LoadEvent());
  }
}
