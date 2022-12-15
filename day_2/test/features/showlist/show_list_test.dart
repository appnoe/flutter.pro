import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workshop_app/features/showlist/presentation/bloc/show_list_bloc.dart';
import 'package:workshop_app/view/show_list.dart';

import '../../mocks.dart';

void main() {
  late MockShowListBloc _mockShowListBloc;

  setUp(() {
    _mockShowListBloc = MockShowListBloc();

    whenListen(
      _mockShowListBloc,
      Stream.fromIterable(
        [
          ShowListInitial(),
          ShowListFailure('kaputt'),
        ],
      ),
    );
    when(() => _mockShowListBloc.state).thenReturn(ShowListFailure('kaputt'));
  });

  Future renderWidget(WidgetTester tester) async {
    final widget = BlocProvider<ShowListBloc>.value(
      value: _mockShowListBloc,
      child: const MaterialApp(home: ShowList(title: 'supertest')),
    );
    await tester.pumpWidget(widget);
  }

  testWidgets('description', (tester) async {
    await renderWidget(tester);

    await tester.pumpAndSettle();
    final finder = find.byKey(ShowList.titleKey);
    await tester.pumpAndSettle();

    expect(finder, findsOneWidget);
  });

  testWidgets('description2', (tester) async {
    await renderWidget(tester);

    await tester.pumpAndSettle();

    final finder = find.byKey(ShowList.errorKey);
    expect(finder, findsOneWidget);
  });
}
