import 'dart:async';

import 'package:clean_arc_proj/feature/domain/entities/person_entity.dart';
import 'package:clean_arc_proj/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:clean_arc_proj/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:clean_arc_proj/feature/presentation/widgets/person_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsList extends StatelessWidget {
  PersonsList({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PersonListCubit>(context).loadPersons();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        bool isLoading = false;
        if (state is PersonLoading && state.isFirstFeatch) {
          return _loadingIndicator();
        } else if (state is PersonLoading) {
          persons = state.oldPersonList;
          isLoading = true;
        } else if (state is PersonLoaded) {
          persons = state.personList;
        } else if (state is PersonError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          );
        }
        return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < persons.length) {
                return PersonCard(person: persons[index]);
              } else {
                Timer(Duration(microseconds: 300), () {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return _loadingIndicator();
              }
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[400],
              );
            },
            itemCount: persons.length + (isLoading ? 1 : 0));
      },
    );
  }
}

Widget _loadingIndicator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
