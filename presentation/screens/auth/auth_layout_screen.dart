import 'package:cinemapedia/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:cinemapedia/presentation/cubits/favoritecubit/favorite_cubit.dart';
import 'package:cinemapedia/presentation/screens/auth/welcome_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLayoutScreen extends StatelessWidget {
  static const name = 'AuthLayoutScreen';
  const AuthLayoutScreen({
    super.key,
    this.pageIfNotconnected,
  });

  final Widget? pageIfNotconnected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const AppLoadingScreen();
        } else if (state is AuthSuccess) {
          // return  BlocProvider(
          //   create: (context) => FavoritesCubit(
          //     DatabaseServices(),
          //   ),
          //   child: const HomeScreen(),
          // );
           return const HomeScreen();

        } else if (state is AuthError) {
          // Puedes mostrar un snackbar, un alert o simplemente pasar a la pantalla no conectada
          return pageIfNotconnected ?? const WelcomePage();
        } else {
          // Para AuthInitial o cualquier otro estado no manejado, redirigir a Welcome
          return pageIfNotconnected ?? const WelcomePage();
        }
      },
    );
  }
}

class AppLoadingScreen extends StatelessWidget {
  const AppLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
