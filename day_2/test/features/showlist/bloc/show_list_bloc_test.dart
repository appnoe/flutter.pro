import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workshop_app/features/showlist/presentation/bloc/show_list_bloc.dart';

import '../../../mocks.dart';

void main() {
  late MockApi _mockApi;

  setUp(() {
    _mockApi = MockApi();
    when(() => _mockApi.fetchShow(any()))
        .thenAnswer((invocation) async => null);
  });

  blocTest<ShowListBloc, ShowListState>(
    'should emit ShowListFailure',
    build: () => ShowListBloc(_mockApi),
    act: (bloc) => bloc.add(LoadSpecificMovie(movieName: 'simpsons')),
    verify: (bloc) => bloc.api.fetchShow('simpsons'),
    expect: () => [ShowListLoading(), ShowListFailure('result is null')],
  );
}
