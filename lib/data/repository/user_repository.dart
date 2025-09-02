import 'package:clean_architecture_riverpod/data/model/user.dart';
import 'package:clean_architecture_riverpod/service/remote/user_service.dart';

class UserRepository {
  final UserService userService;
  UserRepository(this.userService);
  Future<List<User>> getUserList() => userService.getUserList();
}
