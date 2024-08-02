import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/tren_repository.dart';
import 'presentation/screens/tren_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TrenRepository(
            apiUrl: 'https://wbjleyd813.execute-api.us-east-1.amazonaws.com/Prod/tren', // Reemplaza con tu URL
            //accessToken: 'your-access-token', // Reemplaza con tu token
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TrenListView(), // Cambia esto para mostrar tu vista
      ),
    );
  }
}