
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/authlayout',
  routes: [
    GoRoute(
      path: '/authlayout',
      name: AuthLayoutScreen.name ,
      builder: (context, state) =>  AuthLayoutScreen(),
      ),
      
      GoRoute(
    path: '/login',
    name: LoginScreen.name ,
    builder: (context, state) =>  LoginScreen(),
    ),

    GoRoute(
    path: '/signup',
    name: Signup.name ,
    builder: (context, state) =>  Signup(),
    ),

    GoRoute(
      path: '/',
      name: HomeScreen.name ,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name ,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            
            return  MovieScreen(movieId: movieId);
      },
      ),

      GoRoute(
      path: '/favorites',
      name: FavoritesScreen.name ,
      builder: (context, state) =>  FavoritesScreen(), // Tu pantalla de favoritos
    ),

    GoRoute(
      path: '/account',
      name: AccountScreen.name ,
      builder: (context, state) =>  AccountScreen(),
      ),

      ]
      ),

      GoRoute(
      path: '/resetpassword',
      name: ResetPasswordScreen.name ,
      builder: (context, state) =>  ResetPasswordScreen(), // Tu pantalla de favoritos
    ),

    GoRoute(
      path: '/username',
      name: UserNameScreen.name ,
      builder: (context, state) =>  UserNameScreen(), // Tu pantalla de favoritos
    ),


  ]
);