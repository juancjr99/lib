// import 'package:cinemapedia/config/helpers/human_formats.dart';
// import 'package:cinemapedia/presentation/providers/movies/movies/movies_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:animate_do/animate_do.dart';
// class FavoritesScreen extends ConsumerWidget {
//   static const name = 'favorite_screen';
//   const FavoritesScreen({super.key});

//   @override
//   Widget build(BuildContext context, ref) {
//     final _databaseServices = ref.read(databaseProvider);

//     return StreamBuilder(
//       stream: _databaseServices.getMovies(),
//       builder: (context, snapshot) {
//         List movies = snapshot.data?.docs ?? [];
//         final textStyle = Theme.of(context).textTheme;
//         print('******************************** ${movies.length} ****************');
//         return ListView.builder(
//           itemCount: movies.length,
//           itemBuilder: (context, index) {
//             final movie = movies[index].data();
//             return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           //Imagen
//           SizedBox(
//             width: 150,
//             child:  ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child:Image.network(
//                 movie.posterPath,
//                 fit: BoxFit.cover,
//                 width: 150,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if(loadingProgress != null){
//                     return Center(child: const CircularProgressIndicator(strokeWidth: 2));
//                   }
//                   return GestureDetector(
//                     onTap: () => context.push('/movie/${movie.id}'),
//                     child: FadeIn(child: child,)
//                   );
                
//                 },
//               ),
//             ),
//           ),

//           const SizedBox(height: 5,),

//           //Titulo
//           SizedBox(
//             width: 150,
//             child: Text(
//               movie.title,
//               maxLines: 2,
//               style: textStyle.titleSmall,
//             ),
//           ),

//           //Rating
//           Row(children: [
//             Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
//             const SizedBox(width: 3,),
//             Text('${movie.voteAverage}', style: textStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
//             const SizedBox(width: 10,),
//             Text( HumanFormats.number(movie.popularity), style: textStyle.bodySmall),
//           ],)
//         ],
//       ),
//     );
//           },
//         );
//       },
//   );
//   }
// }
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
