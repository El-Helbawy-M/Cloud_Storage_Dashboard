part of 'object_cubit.dart';

@immutable
abstract class ObjectsState {}

class ObjectsInitial extends ObjectsState {}

class ObjectsLoaded extends ObjectsState {
  final List<Object> objects;
  ObjectsLoaded(this.objects);
}
