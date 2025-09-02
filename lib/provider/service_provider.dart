import 'package:clean_architecture_riverpod/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/remote/user_service.dart';

final userServiceProvider = Provider((ref) => UserService());
final userRepositoryProvider = Provider(
  (ref) => UserRepository(ref.read(userServiceProvider)),
);
