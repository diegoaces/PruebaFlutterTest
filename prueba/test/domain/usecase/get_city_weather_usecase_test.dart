import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prueba/core/failures/failure.dart';
import 'package:prueba/core/usecase/usecase.dart';
import 'package:prueba/domain/repositories/repository.dart';
import 'package:prueba/domain/usecase/get_city_weather_usecase.dart';

import 'get_city_weather_usecase_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  MockRepository mockRepository = MockRepository();
  GetCityWeatherUseCase getCityWeatherUseCase =
      GetCityWeatherUseCase(mockRepository);

  test('GetCityWeatherUseCase is a UseCase instance', () {
    //assert
    expect(getCityWeatherUseCase, isA<UseCase>());
  });

  test('should return a Right<String> with the text "Texto de prueba"',
      () async {
    //arrange
    const String city = 'Chillan';

     when(mockRepository.getCityWeather(any))
        .thenAnswer((_) async => const Right('Texto de prueba'));
        
    //act
    final result = await getCityWeatherUseCase(CityParams(city));
    //assert
    expect(result, const Right('Texto de prueba'));
  });

  test(
      'should return a Right<String> with the text "Texto de prueba" from repository',
      () async {
    //arrange
    const String city = 'Chillan';
    when(mockRepository.getCityWeather(any))
        .thenAnswer((_) async => const Right('Texto de prueba'));
    //act
    final result = await getCityWeatherUseCase(CityParams(city));
    //assert
    verify(mockRepository.getCityWeather(city));
    expect(result, const Right('Texto de prueba'));
  });

  test('should return a Left<Failure> with a RepositoryFailure instance',
      () async {
    //arrange
    const String city = 'Chillan';
    when(mockRepository.getCityWeather(any))
        .thenAnswer((_) async => Left(RepositoryFailure()));
    //act
    final result = await getCityWeatherUseCase(CityParams(city));
    //assert
    expect(result, Left(RepositoryFailure()));
  });
}
