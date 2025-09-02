import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture_riverpod/provider/user_provider.dart';
import 'package:clean_architecture_riverpod/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(getUserListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text("Unexpected error: $err"),
        ),
        data: (either) {
          return either.fold(
            (appException) => Center(
              child: Text("Error: ${appException.toString()}"),
            ),
            (users) {
              if (users.isEmpty) {
                return const Center(
                  child: Text("No users found"),
                );
              }
              return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user.avatarUrl != null
                          ? NetworkImage(user.avatarUrl!)
                          : null,
                      child: user.avatarUrl == null
                          ? Text(user.name.isNotEmpty ? user.name[0] : "?")
                          : null,
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    onTap: () {
                      context.router.push(GameRoute());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tapped on ${user.name}")),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
