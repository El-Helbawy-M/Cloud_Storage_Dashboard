import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'object_state.dart';

class ObjectsCubit extends Cubit<ObjectsState> {
  ObjectsCubit() : super(ObjectsInitial());
}
