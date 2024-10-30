import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nvp_test/model/edit_profile_model.dart';
import 'package:nvp_test/model/register_model.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Creates a new user document in Firestore.
  /// This function will first check if a user document with the given user's uid
  /// already exists in Firestore. If it doesn't, the user document will be created
  /// with the given [RegisterModel].
  Future<void> signUp(
      {required RegisterModel model, required User user}) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        _firestore.collection('users').doc(user.uid).set({
          'name': model.name,
          'email': model.email,
          'latitude': model.latitude,
          'longitude': model.longitude,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Gets a stream of the user document snapshot based on the logged in user uid.
  /// The stream will emit the user document snapshot whenever the document is
  /// changed.
  Stream<RegisterModel?> getUserModelStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return RegisterModel.fromJson(snapshot.data()!);
      } else {
        return null;
      }
    });
  }

  /// Edit the existing user document in Firestore.
  Future<void> editProfile({
    required String uid,
    required EditProfileModel model,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update(model.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
