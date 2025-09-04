import 'package:clean_architecture_riverpod/data/model/user.dart';
import 'package:clean_architecture_riverpod/service/either.dart';
import 'package:clean_architecture_riverpod/service/exception/app_exception.dart';
import 'package:clean_architecture_riverpod/service/remote/user_service.dart';

class UserRepository {
  final UserService userService;
  UserRepository(this.userService);
  Future<Either<AppException,List<User>>> getUserList() => userService.getUserList();
  Future<Either<AppException,User>> getUserInfo() => userService.getUserInfo();
}
