import 'package:clean_architecture_riverpod/data/repository/user_repository.dart';
import 'package:clean_architecture_riverpod/service/exception/app_exception.dart';
import 'package:clean_architecture_riverpod/service/remote/dio_client.dart';
import 'package:clean_architecture_riverpod/service/remote/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late UserService userService;
  late UserRepository userRepository;

  const testUrl = "https://api.example.com"; // mock flavor url
  const endpoint = "/19f36f20c618f77c8327";

  setUp(() {
    // Setup Dio + mock adapter
    dio = Dio(BaseOptions(baseUrl: testUrl));
    dioAdapter = DioAdapter(dio: dio);

    // Override static DioClient.dio with mocked Dio
    DioClient.dio.httpClientAdapter = dioAdapter;

    userService = UserService();
    userRepository = UserRepository(userService);
  });

  group("UserService", () {
    test("✅ returns UserModel on success", () async {
      final mockJson = {
        "id": "1",
        "name": "John Doe",
        "email": "john@example.com",
        "avatarUrl": "link", // 👈 will be parsed to true
      };

      dioAdapter.onGet(endpoint, (request) => request.reply(200, mockJson));

      final result = await userRepository.getUserInfo();

      expect(result.isRight(), true);
      result.fold((err) => fail("Should not fail"), (user) {
        expect(user.name, "John Doe");
        expect(user.email, "john@example.com");
      });
    });

    test("❌ returns AppException on server error", () async {
      dioAdapter.onGet(
        endpoint,
        (request) => request.reply(500, {"error": "server error"}),
      );

      final result = await userRepository.getUserInfo();

      expect(result.isLeft(), true);
      result.fold((err) {
        expect(err, isA<AppException>());
        //expect(err.toString(), startsWith("Error During Communication:"));
        expect(err.toString(), contains("500"));
      }, (user) => fail("Should not succeed"));
    });

    test("❌ returns AppException on timeout", () async {
      dioAdapter.onGet(
        endpoint,
        (request) => request.throws(
          408,
          DioException.connectionTimeout(
            requestOptions: RequestOptions(path: endpoint),
            timeout: const Duration(seconds: 10),
          ),
        ),
      );

      final result = await userRepository.getUserInfo();

      expect(result.isLeft(), true);
      result.fold((err) {
        expect(err, isA<AppException>());
        expect(err.toString(), contains("timeout"));
      }, (user) => fail("Should not succeed"));
    });
  });
}
