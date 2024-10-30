import 'package:firebase_auth/firebase_auth.dart';
import 'package:nvp_test/model/login_model.dart';
import 'package:nvp_test/model/register_model.dart';
import 'package:nvp_test/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Creates a new user with the given [RegisterModel].
  /// This function will call [FirebaseAuth.createUserWithEmailAndPassword] to create a new user,
  /// and then call [FirestoreServices.signUp] to create a new user document in Firestore.
  Future<User?> signUp({required RegisterModel model}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: model.email ?? '', password: model.password ?? '');
      final user = userCredential.user;
      if (user != null) {
        await FirestoreServices().signUp(model: model, user: user);
      }
      return user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Signs in an existing user with the given [LoginModel].
  /// This function will call [FirebaseAuth.signInWithEmailAndPassword] to sign in the user.
  /// If the user is signed in successfully, the user object will be returned.
  Future<User?> signIn({required LoginModel model}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: model.email ?? '', password: model.password ?? '');
      final user = userCredential.user;
      return user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// Checks if a user is currently signed in.
  /// This function will return true if there is a signed in user, and false otherwise.
  Future<bool> checkUserLogin() async {
    try {
      User? user = _auth.currentUser;
      return user != null;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  getUid() {
    User? user = _auth.currentUser;
    return user?.uid;
  }

  logout() async {
    await _auth.signOut();
  }
}
