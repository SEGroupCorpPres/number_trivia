import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/remote/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();

  Future<NumberTriviaModel> getRandomNumberYearTrivia();

  Future<NumberTriviaModel> getRandomNumberDateTrivia();

  Future<NumberTriviaModel> getRandomNumberMathTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromUrl('http://numbersapi.com/$number?json');

  @override
  Future<NumberTriviaModel> getRandomNumberDateTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random/date?json');

  @override
  Future<NumberTriviaModel> getRandomNumberMathTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random/math?json');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random/trivia?json');

  @override
  Future<NumberTriviaModel> getRandomNumberYearTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random/year?json');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {

    final response = await client.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader.toUpperCase(): ContentType.json.primaryType},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ServerException();
    }
    return NumberTriviaModel.fromJson(jsonDecode(response.body));
  }
}
