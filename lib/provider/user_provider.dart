
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'service_provider.dart';

final getUserListProvider = FutureProvider.autoDispose((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return await userRepository.getUserList();
});
