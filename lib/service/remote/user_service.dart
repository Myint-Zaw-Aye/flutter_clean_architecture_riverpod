import 'package:clean_architecture_riverpod/data/model/user.dart';
import 'package:clean_architecture_riverpod/service/either.dart';
import 'package:clean_architecture_riverpod/service/exception/app_exception.dart';
import 'package:dio/dio.dart';
import '../../core/config/flavour_manager.dart';
import 'dio_client.dart';
import '../handler/dio_request_handler.dart';

class UserService {
  String mainUrl = FlavorManager.env?.baseUrl?? "";

  Future<Either<AppException,List<User>>> getUserList() {
    return DioRequestHandler.handleRequest<List<User>>(
      () {
        return DioClient.dio.get("$mainUrl/fe754a12db62627cb657",
          options: Options(
            headers: {
              'Accept': 'application/json',
            },
          ),
        );
      },
      (json) => (json as List).map((e) => User.fromJson(e)).toList(),
    );
  }

  
}
