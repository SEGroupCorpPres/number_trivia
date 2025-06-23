import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/use_cases/use_case.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCaseWithParams<NumberTrivia, NoParams> {
  final NumberTriviaRepository _numberTriviaRepository;

  GetRandomNumberTrivia(this._numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async =>
      await _numberTriviaRepository.getRandomNumberTrivia();
}
