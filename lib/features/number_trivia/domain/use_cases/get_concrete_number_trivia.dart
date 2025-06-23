import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/use_cases/use_case.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCaseWithParams<NumberTrivia, Params> {
  final NumberTriviaRepository _numberTriviaRepository;

  GetConcreteNumberTrivia(this._numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async =>
      await _numberTriviaRepository.getConcreteNumberTrivia(params.number);
}
