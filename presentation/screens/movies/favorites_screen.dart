import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/presentation/providers/movies/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class FavoritesScreen extends ConsumerWidget {
  static const name = 'favorite_screen';
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _databaseServices = ref.read(databaseProvider);
    

    return SafeArea(
      child: StreamBuilder(
        stream: _databaseServices.getMovies(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
      
          List movies = snapshot.data!.docs;
          final textStyle = Theme.of(context).textTheme;
      
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: movies.map((doc) {
                final movie = doc.data();
                String movieid = doc.id;
                // print('Movie id: $movieid');
                return SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ 
                      
      
                      // Imagen
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          movie.posterPath,
                          fit: BoxFit.cover,
                          height: 220,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress != null) {
                              return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                            }
                            return GestureDetector(
                              onTap: () => context.push('/movie/${movie.id}'),
                              onLongPress: ()=> _databaseServices.deleteMovie(movieid),
                              child: FadeIn(child: child),
                            );
                          },
                        ),
                      ),
      
                      const SizedBox(height: 5),
      
                      // Título
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle.titleSmall,
                      ),
      
                      // Rating
                      Row(
                        children: [
                          Icon(Icons.star_half_outlined, color: Colors.yellow.shade800, size: 16),
                          const SizedBox(width: 3),
                          Text(
                            '${movie.voteAverage}',
                            style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            HumanFormats.number(movie.popularity),
                            style: textStyle.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
