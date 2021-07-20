import 'dart:convert';

import 'package:clean_arc_proj/core/error/exeption.dart';
import 'package:clean_arc_proj/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHE_KEY = 'CACHED_PERSON_LIST';

abstract class PersonLocalDataSource {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] in no cached data is presents
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonList = sharedPreferences.getStringList(CACHE_KEY);
    if (jsonPersonList!.isNotEmpty) {
      return Future.value(jsonPersonList
          .map((person) => PersonModel.fromJson(jsonDecode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHE_KEY, jsonPersonsList);
    print('Persons to write Cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
