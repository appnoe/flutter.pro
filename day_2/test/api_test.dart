import 'package:flutter_login/flutter_login.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:workshop_app/api/api.dart';

void main() {
  late Api _sut;

  setUp(() {
    _sut = Api();
  });

  group('validateUser', () {
    test('should respond with true when valid', () async {
      final loginData = LoginData(name: 'user', password: 'user');
      final result = await _sut.validateUser(loginData);
      expect(result, true);
    });
    test('should respond with false when invalid', () async {
      final loginData = LoginData(name: 'user', password: 'user2');
      final result = await _sut.validateUser(loginData);
      expect(result, false);
    });
  });
}
