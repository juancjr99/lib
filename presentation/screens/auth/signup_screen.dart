
import 'package:cinemapedia/presentation/cubits/authcubit/auth_cubit.dart';
import 'package:cinemapedia/presentation/cubits/favoritecubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Signup extends StatelessWidget {
  static const name = 'SignupScreen';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _username = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              // Muestra el error en caso de un fallo en la autenticación
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AuthSuccess) {
              // Redirige a la siguiente pantalla cuando el registro es exitoso
              context.pop();
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                    TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      labelText: 'Nombre de Usuario',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa nuevo nombre de usuario';
                      }
                      return null;
                    },
                  ),
                  
                                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo';
                      }
                      // Validación simple de correo
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Por favor ingresa un correo válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10.0),
                  if (state is AuthLoading) 
                    Center(child: CircularProgressIndicator()), // Muestra el indicador de carga
                  SizedBox(height: 18.0),
                  if (state is! AuthLoading) 
                  ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        try{
                          await context.read<AuthCubit>().signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          await context.read<AuthCubit>().updateUsername(_username.text,);  
                          context.read<FavoritesCubit>().updateUser();
                        }catch (e) {
                                  // Mostrás un diálogo, snackbar, lo que quieras
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: ${e.toString()}')),
                                  );
                                }
                      }
                    },
                    child: Text('Registrarse'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
