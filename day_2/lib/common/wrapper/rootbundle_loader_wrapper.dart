// coverage: ignore-file
import 'package:flutter/services.dart';

class RootBundleLoaderWrapper {
  load(String path) async {
    rootBundle.load(path);
  }
}
