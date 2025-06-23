import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/use_cases/use_case.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_date_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_math_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/use_cases/get_random_number_year_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia _getConcreteNumberTrivia;
  final GetRandomNumberTrivia _getRandomNumberTrivia;
  final GetRandomNumberDateTrivia _getRandomNumberDateTrivia;
  final GetRandomNumberYearTrivia _getRandomNumberYearTrivia;
  final GetRandomNumberMathTrivia _getRandomNumberMathTrivia;
  final InputConverter _inputConverter;

  NumberTriviaBloc({
    required InputConverter inputConverter,
    required GetConcreteNumberTrivia getConcreteNumberTrivia,
    required GetRandomNumberTrivia getRandomNumberTrivia,
    required GetRandomNumberDateTrivia getRandomNumberDateTrivia,
    required GetRandomNumberYearTrivia getRandomNumberYearTrivia,
    required GetRandomNumberMathTrivia getRandomNumberMathTrivia,
  }) : _getConcreteNumberTrivia = getConcreteNumberTrivia,
       _getRandomNumberDateTrivia = getRandomNumberDateTrivia,
       _getRandomNumberTrivia = getRandomNumberTrivia,
       _getRandomNumberYearTrivia = getRandomNumberYearTrivia,
       _getRandomNumberMathTrivia = getRandomNumberMathTrivia,
       _inputConverter = inputConverter,
       super(InitialNumberTriviaState()) {
    on<GetTriviaForConcreteNumber>(_getConcreteNumberTriviaData);
    on<GetTriviaForRandomTrivia>(_getRandomNumberTriviaData);
    on<GetTriviaForRandomDate>(_getRandomNumberDateTriviaData);
    on<GetTriviaForRandomYear>(_getRandomNumberYearTriviaData);
    on<GetTriviaForRandomMath>(_getRandomNumberMathTriviaData);
  }

  Future<void> _getConcreteNumberTriviaData(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither = _inputConverter.stringToUnsignedInt(event.numberString);
      inputEither.fold(
        (failure) {
          emit(ErrorNumberTriviaState(INVALID_INPUT_FAILURE_MESSAGE));
        },
        (integer) async {
          emit(LoadingNumberTriviaState());
          final failureOrTrivia = await _getConcreteNumberTrivia(Params(number: integer));
          _eitherLoadedOrErrorStata(failureOrTrivia, emit);
        },
      );
    }
  }

  Future<void> _getRandomNumberDateTriviaData(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    if (event is GetTriviaForRandomDate) {
      emit(LoadingNumberTriviaState());
      final failureOrTrivia = await _getRandomNumberDateTrivia(NoParams());
      _eitherLoadedOrErrorStata(failureOrTrivia, emit);
    }
  }

  Future<void> _getRandomNumberTriviaData(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    if (event is GetTriviaForRandomTrivia) {
      emit(LoadingNumberTriviaState());
      final failureOrTrivia = await _getRandomNumberTrivia(NoParams());
      _eitherLoadedOrErrorStata(failureOrTrivia, emit);
    }
  }

  Future<void> _getRandomNumberYearTriviaData(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    if (event is GetTriviaForRandomYear) {
      emit(LoadingNumberTriviaState());
      final failureOrTrivia = await _getRandomNumberYearTrivia(NoParams());
      _eitherLoadedOrErrorStata(failureOrTrivia, emit);
    }
  }

  Future<void> _getRandomNumberMathTriviaData(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    if (event is GetTriviaForRandomMath) {
      emit(LoadingNumberTriviaState());
      final failureOrTrivia = await _getRandomNumberMathTrivia(NoParams());
      _eitherLoadedOrErrorStata(failureOrTrivia, emit);
    }
  }

  Future<void> _eitherLoadedOrErrorStata(Either<Failure, NumberTrivia> failureOrTrivia, Emitter<NumberTriviaState> emit) async {
    failureOrTrivia.fold(
      (failure) {
        emit(ErrorNumberTriviaState(_mapFailureToMessage(failure)));
      },
      (trivia) {
        emit(LoadedNumberTriviaState(trivia));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure _:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
