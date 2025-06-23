import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/data/local/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/remote/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_date_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_math_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_year_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(
      () => NumberTriviaBloc(
        inputConverter: sl(),
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
        getRandomNumberDateTrivia: sl(),
        getRandomNumberYearTrivia: sl(),
        getRandomNumberMathTrivia: sl(),
      ),
    )
    ..registerLazySingleton(() => GetRandomNumberDateTrivia(sl()))
    ..registerLazySingleton(() => GetConcreteNumberTrivia(sl()))
    ..registerLazySingleton(() => GetRandomNumberYearTrivia(sl()))
    ..registerLazySingleton(() => GetRandomNumberMathTrivia(sl()))
    ..registerLazySingleton(() => GetRandomNumberTrivia(sl()))
    ..registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(sl(), sl(), sl()),
    )
    ..registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
    )
    ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(() => InputConverter())
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(() => http.Client())
    ..registerLazySingleton(() => InternetConnection());
}
