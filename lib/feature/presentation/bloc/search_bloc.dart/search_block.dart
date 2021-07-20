import 'package:clean_arc_proj/core/error/failure.dart';
import 'package:clean_arc_proj/feature/domain/usecases/search_person.dart';
import 'package:clean_arc_proj/feature/presentation/bloc/search_bloc.dart/search_event.dart';
import 'package:clean_arc_proj/feature/presentation/bloc/search_bloc.dart/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;
  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  @override
  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: personQuery)); // !!!!!!!

    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person));
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
