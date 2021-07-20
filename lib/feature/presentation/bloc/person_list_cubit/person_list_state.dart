import 'package:clean_arc_proj/feature/domain/entities/person_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable {
  const PersonState();
  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFeatch;

  PersonLoading(this.oldPersonList, {this.isFirstFeatch = false});

  @override
  List<Object?> get props => [oldPersonList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntity> personList;

  PersonLoaded(this.personList);

  @override
  List<Object?> get props => [personList];
}

class PersonError extends PersonState {
  final String message;

  PersonError({required this.message});

  @override
  List<Object?> get props => [message];
}