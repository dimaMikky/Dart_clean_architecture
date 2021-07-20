import 'package:clean_arc_proj/commmon/app_colors.dart';
import 'package:clean_arc_proj/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:clean_arc_proj/feature/presentation/bloc/search_bloc.dart/search_block.dart';
import 'package:clean_arc_proj/feature/presentation/pages/person_screen.dart';
import 'package:clean_arc_proj/locator_service.dart' as di;
import 'package:clean_arc_proj/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
              create: (context) => sl<PersonListCubit>()..loadPersons()),
          BlocProvider<PersonSearchBloc>(
              create: (context) => sl<PersonSearchBloc>()),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
              backgroundColor: AppColors.mainBackground,
              scaffoldBackgroundColor: AppColors.mainBackground),
          home: MyhomePage(),
        ));
  }
}
