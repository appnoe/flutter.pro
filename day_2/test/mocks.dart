import 'package:mocktail/mocktail.dart';
import 'package:workshop_app/api/api.dart';
import 'package:workshop_app/features/showlist/presentation/bloc/show_list_bloc.dart';

class MockApi extends Mock implements Api {}
class MockShowListBloc extends Mock implements ShowListBloc {}