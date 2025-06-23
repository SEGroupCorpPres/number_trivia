part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  int get number => int.parse(numberString);

  GetTriviaForConcreteNumber(this.numberString);

  @override
  // TODO: implement props
  List<Object?> get props => [numberString];
}

class GetTriviaForRandomTrivia extends NumberTriviaEvent {}

class GetTriviaForRandomDate extends NumberTriviaEvent {}

class GetTriviaForRandomYear extends NumberTriviaEvent {}

class GetTriviaForRandomMath extends NumberTriviaEvent {}
