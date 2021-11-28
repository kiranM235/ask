import 'package:ask/src/repo/ask_api_provider.dart';
import 'package:ask/src/repo/ask_db_provider.dart';
import 'package:ask/src/repo/repository.dart';
import 'package:ask/src/screens/ask_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main () {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());

}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final apiProvider = AskApiProvider();
  final dbProvider = AskDbProvider();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(dbProvider, apiProvider),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ask Show & Job Stories App',
        home: AskScreen(),
      ),
    );
  }
}