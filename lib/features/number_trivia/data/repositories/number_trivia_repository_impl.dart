import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/core/util/type_defs.dart';
import 'package:number_trivia/features/number_trivia/data/local/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/remote/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/remote/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource _remoteDataSource;
  final NumberTriviaLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  NumberTriviaRepositoryImpl(
     this._remoteDataSource,
     this._localDataSource,
     this._networkInfo,
  );

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async =>
      await _getTrivia(() => _remoteDataSource.getConcreteNumberTrivia(number));

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberDateTrivia() async =>
      await _getTrivia(() => _remoteDataSource.getRandomNumberDateTrivia());

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberMathTrivia() async =>
      await _getTrivia(() => _remoteDataSource.getRandomNumberMathTrivia());

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async =>
      await _getTrivia(() => _remoteDataSource.getRandomNumberTrivia());

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberYearTrivia() async =>
      await _getTrivia(() => _remoteDataSource.getRandomNumberYearTrivia());

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    ConcreteOrRandomChooser getConcreteOrRandomTrivia,
  ) async {
    if (await _networkInfo.isConnected!) {
      try {
        final remoteTrivia = await getConcreteOrRandomTrivia();
        _localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await _localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
