import 'package:flutter/material.dart';

class FullScrennLoader extends StatelessWidget {
    FullScrennLoader({super.key});

  final messages = <String>[
      'Cargando peliculas',
      'Comprando palomitas de maiz',
      'Cargando populares',
      'Ya casi...',
      'Esto esta tardando mas de lo esperado :(',
      
  ];

  Stream<String> getLoadingMessages(){
    return Stream.periodic(const Duration(milliseconds: 1500), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere"),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text('Cargando...');
              return Text(snapshot.data!);
            },)
        ],
      ),
    );
  }
}