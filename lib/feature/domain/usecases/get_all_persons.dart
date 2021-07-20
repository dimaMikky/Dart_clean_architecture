import 'package:clean_arc_proj/core/error/failure.dart';
import 'package:clean_arc_proj/core/usecases/usecase.dart';
import 'package:clean_arc_proj/feature/domain/entities/person_entity.dart';
import 'package:clean_arc_proj/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
