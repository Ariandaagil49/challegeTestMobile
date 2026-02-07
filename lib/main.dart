import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/injector.dart';
import 'features/presentation/bloc/user_cubit.dart';
import 'features/presentation/pages/user_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Injector().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (_) => Injector().userCubit..fetchUsers(),
      child: MaterialApp(
        title: 'CRUD Software',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        home: const UserListPage(),
      ),
    );
  }
}
