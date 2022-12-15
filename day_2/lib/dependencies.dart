import 'package:get_it/get_it.dart';

import 'api/api.dart';

Future<void> initializeIoC() async {
  await _registerWrapper();
  await _registerUseCases();
  await _registerBlocs();
}

Future _registerWrapper() async {
}

Future _registerUseCases() async {
  singleton(() => Api());
}

Future _registerBlocs() async {}


T get<T extends Object>({dynamic param}) {
  return getFunc<T>(param: param);
}

T Function<T extends Object>({dynamic param}) getFunc = _get;

T _get<T extends Object>({dynamic param}) {
  return GetIt.instance.get<T>(param1: param);
}

void singleton<T extends Object>(T Function() constructor, [void singleton]) {
  GetIt.instance.registerLazySingleton<T>(constructor);
}

void factory<T extends Object>(T Function() constructor) {
  GetIt.instance.registerFactory<T>(constructor);
}
