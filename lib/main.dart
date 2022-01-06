import 'package:flutter/material.dart';
import 'package:randomperson/features/cubit/user_cubit.dart';
import 'package:randomperson/helper/service_locator.dart';
import 'package:randomperson/pages/home/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random People',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<UserCubit>(
        create: (context) => UserCubit(),
        child: const HomePage(),
      ),
    );
  }
}
