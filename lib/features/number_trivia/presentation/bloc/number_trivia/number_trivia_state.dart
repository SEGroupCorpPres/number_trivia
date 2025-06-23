part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialNumberTriviaState extends NumberTriviaState {}

class LoadingNumberTriviaState extends NumberTriviaState {}

class ErrorNumberTriviaState extends NumberTriviaState {
  final String message;

  ErrorNumberTriviaState(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class LoadedNumberTriviaState extends NumberTriviaState {
  final NumberTrivia trivia;
  LoadedNumberTriviaState(this.trivia);
  @override
  // TODO: implement props
  List<Object?> get props => [trivia];
}

class Empty extends NumberTriviaState {}