import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  AuthCubit() : super(AuthInitial()){_checkCurrentUser();}
  
void _checkCurrentUser() {
  final user = firebaseAuth.currentUser;
  if (user != null) {
    emit(AuthSuccess(user));
  } else {
    emit(AuthInitial());
  }
}

  Future<UserCredential> signIn({
    required String email,
    required String password,
  })async{
    try{
      emit(AuthLoading()); // Emite el estado de carga
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
      );
      emit(AuthSuccess(userCredential.user!)); // Emite el estado de éxito con el usuario
      return userCredential;
    }catch (e) {
      emit(AuthError(e.toString())); // Emite el estado de error con el mensaje
      rethrow; // Vuelve a lanzar la excepción para manejarla en el lugar donde se llama
    }
    
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  })async{
    try{
      emit(AuthLoading()); // Emite el estado de carga
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
      emit(AuthSuccess(userCredential.user!)); // Emite el estado de éxito con el usuario
      return userCredential;
    } catch (e) {
      emit(AuthError(e.toString())); // Emite el estado de error con el mensaje
      rethrow; // Vuelve a lanzar la excepción para manejarla en el lugar donde se llama
    }
  }
  
  
  Future<void> signOut()async{
    try{
      emit(AuthLoading()); // Emite el estado de carga
      await firebaseAuth.signOut();
      emit(AuthInitial()); // Emite el estado inicial después de cerrar sesión
    }catch (e){
      emit(AuthError(e.toString())); // Emite el estado de error con el mensaje
    }
  }

  Future<void> ResetPassword(String email)async{
    try{
      emit(AuthLoading()); // Emite el estado de carga
      await firebaseAuth.sendPasswordResetEmail(email: email);
      emit(AuthSuccess(currentUser!)); // Emite el estado de éxito
    }catch (e){
      emit(AuthError(e.toString())); // Emite el estado de error con el mensaje
    }
  }

  Future<void> updateUsername(String username) async {
    try {
      emit(AuthLoading()); // Emite el estado de carga
      await currentUser!.updateDisplayName(username);
      emit(AuthSuccess(currentUser!)); // Emite el estado de éxito con el usuario
    } catch (e) {
      emit(AuthError(e.toString())); // Emite el estado de error con el mensaje
    }
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  })async{
    try{
      emit(AuthLoading()); // Emite el estado de carga
      AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
    emit(AuthInitial()); // Emite el estado inicial después de eliminar la cuenta
    }catch (e){
      emit(AuthError(e.toString())); // Emite el estado de error con el mensaje
    }  
  }

  Future<void> ResetPasswordFronCurrentPassword({
    required String email,
    required String password,
    required String currentPassword,
  })async{
    try{  
      emit(AuthLoading()); // Emite el estado de carga
      AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(password);
    emit(AuthSuccess(currentUser!)); // Emite el estado de éxito
    }catch(e){
      emit(AuthError(e.toString())); // Emite el estado de error con el mensaje
    }
  }

}
