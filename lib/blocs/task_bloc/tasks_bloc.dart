import 'package:equatable/equatable.dart';
import 'package:todo_using_bloc/model/task.dart';

import '../bloc_export.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavouriteTask>(_onMarkFavouriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
  }
  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTasks: List.from(state.pendingTasks)..add(event.task),
          completedTasks: state.completedTasks,
          favouriteTasks: state.favouriteTasks,
          removedTasks: state.removedTasks),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedtasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (task.isDone == false) {
      if (task.isFavourite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedtasks.insert(0, task.copyWith(isDone: true));
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedtasks.insert(0, task.copyWith(isDone: true));
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavourite == false) {
        completedtasks = List.from(completedtasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        completedtasks = List.from(completedtasks)..remove(event.task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
        favouriteTasks = List.from(favouriteTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }
    ;
    emit(
      TasksState(
          pendingTasks: pendingTasks,
          completedTasks: completedtasks,
          favouriteTasks: state.favouriteTasks,
          removedTasks: state.removedTasks),
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTasks: state.pendingTasks,
          completedTasks: state.completedTasks,
          favouriteTasks: state.favouriteTasks,
          removedTasks: List.from(state.removedTasks)..remove(event.task)),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..remove(event.task),
      completedTasks: List.from(state.completedTasks)..remove(event.task),
      favouriteTasks: List.from(state.favouriteTasks)..remove(event.task),
      removedTasks: List.from(state.removedTasks)
        ..add(event.task.copyWith(isDeleted: true)),
    ));
  }

  void _onMarkFavouriteTask(MarkFavouriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavourite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavourite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    }
    emit(
      TasksState(
          pendingTasks: pendingTasks,
          completedTasks: completedTasks,
          favouriteTasks: favouriteTasks,
          removedTasks: state.removedTasks),
    );
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favouriteTasks;
    if (event.oldTask.isFavourite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: state.completedTasks..remove(event.oldTask),
        favouriteTasks: favouriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
          0,
          event.task
              .copyWith(isDeleted: false, isDone: false, isFavourite: false),
        ),
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
    ));
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..clear(),
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
