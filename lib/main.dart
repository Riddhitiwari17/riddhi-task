import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riddhi_task/blocs/bookmark/bookmark_bloc.dart';
import 'package:riddhi_task/blocs/login/login_bloc.dart';
import 'package:riddhi_task/blocs/user/user_bloc.dart';
import 'package:riddhi_task/screens/bookmark_screen.dart';
import 'package:riddhi_task/screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => BookmarkBloc()..loadBookmarks()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dummy Login with API',
        routes: {
          '/': (_) => const LoginScreen(),
          '/home': (_) => const HomeScreen(),
          '/bookmarks': (_) => const BookmarksScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}
