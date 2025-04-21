import 'package:cinemapedia/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:cinemapedia/presentation/cubits/favoritecubit/favorite_cubit.dart';
import 'package:cinemapedia/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp( ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FavoritesCubit>(
            create: (context) => FavoritesCubit(
              DatabaseServices(),
            ),),
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(),
          ),
        ],

    child: MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
