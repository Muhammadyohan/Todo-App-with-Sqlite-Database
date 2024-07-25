import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final int id;
  final String name;
  final int cycleDays;
  final DateTime? lastTime;

  const TodoModel(this.id, this.name, this.cycleDays, this.lastTime);

  factory TodoModel.fromJson(dynamic data) => TodoModel(
        data['id'],
        data['name'],
        data['cycleDays'],
        data['lastTime'] != null ? DateTime.parse(data['lastTime']) : null,
      );

  @override
  List<Object?> get props => [id, lastTime];
}
