import 'package:clean_arc_proj/core/error/failure.dart';
import 'package:clean_arc_proj/feature/domain/entities/person_entity.dart';
import 'package:clean_arc_proj/feature/domain/usecases/get_all_persons.dart';
import 'package:clean_arc_proj/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;
  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;
  void loadPersons() async {
    final currentState = state;

    if (currentState is PersonLoading) return;

    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personList;
    }

    emit(PersonLoading(oldPerson, isFirstFeatch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonList;
      persons.addAll(character);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
