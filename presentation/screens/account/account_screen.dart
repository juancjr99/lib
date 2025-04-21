
import 'package:cinemapedia/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  static const name = 'AccountScreen';

  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.read<AuthCubit>(); 
    final user = authCubit.currentUser;


    return Scaffold( 
      appBar: AppBar(
        title: const Text('Cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Text(
              user?.displayName ?? 'Usuario',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? 'Sin correo',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const Divider(height: 32),

            ListTile(
              leading: const Icon(Icons.person_3_outlined),
              title: const Text('Actualizar nombre de usuario'),
              onTap: () {
                context.push('/username');
                
              },
            ),

            ListTile(
              leading: const Icon(Icons.lock_clock_outlined),
              title: const Text('Cambiar contraseña'),
              onTap: () {
                context.push('/resetpassword');
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Cerrar sesión'),
              onTap: () async{
                try{
                  await authCubit.signOut();
                }on FirebaseAuthException catch(e){
                 // Mostrás un diálogo, snackbar, lo que quieras
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                                
                }



                
              }
            ),

            ListTile(
              leading: const Icon(Icons.delete_outlined),
              title: const Text('Eliminar cuenta'),
              textColor: Colors.red,
              iconColor: Colors.red,
              onTap: () {
                // TODO: Confirmar y navegar a pantalla de eliminación de cuenta
              },
            ),

            const Spacer(),

          ],
        ),
      ),
    );
  }
}
