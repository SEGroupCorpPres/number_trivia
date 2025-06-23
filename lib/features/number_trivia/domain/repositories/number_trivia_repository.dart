import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();

  Future<Either<Failure, NumberTrivia>> getRandomNumberYearTrivia();

  Future<Either<Failure, NumberTrivia>> getRandomNumberDateTrivia();

  Future<Either<Failure, NumberTrivia>> getRandomNumberMathTrivia();
}
