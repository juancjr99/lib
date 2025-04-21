
import 'package:cinemapedia/presentation/cubits/favoritecubit/favorite_cubit.dart';
import 'package:cinemapedia/presentation/providers/navigation/navigation_provider.dart';
import 'package:cinemapedia/presentation/screens/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/movies/movies/movies_slideshow_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

import '../../providers/providers.dart';


class HomeScreen extends ConsumerWidget  {

  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final navigation = ref.watch(navigationProvider);
    return  Scaffold(
      body: IndexedStack(
        index: navigation.selectedIndex,
        children:[
          _HomeView(),
          FavoritesScreen(),
          AccountScreen(),
        ]),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();

    

  }
  @override
  Widget build(BuildContext context) {


    final initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading) {

      return  FullScrennLoader();}


    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies= ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);



    return  CustomScrollView(
      slivers:[
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
        children: [
          MoviesSlideshow(movies: slideShowMovies),
      
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'En Cines',
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
            ),
      
            MovieHorizontalListview(
            movies: upcomingMovies,
            title: 'Proximamente',
            loadNextPage: () {
              ref.read(upcomingMoviesProvider.notifier).loadNextPage();
            },
            ),
      
            MovieHorizontalListview(
            movies: popularMovies,
            title: 'Populares',
            //subTitle: 'En este mes',
            loadNextPage: () {
              ref.read(popularMoviesProvider.notifier).loadNextPage();
            },
            ),
      
            MovieHorizontalListview(
            movies: topRatedMovies,
            title: 'Mejor Calificada',
            subTitle: 'De siempre',
            loadNextPage: () {
              ref.read(topRatedMoviesProvider.notifier).loadNextPage();
            },
            ),

            const SizedBox(height: 10,)
        ],
      );
          },
          childCount: 1

        ))

      ]
      
    );
  }
}