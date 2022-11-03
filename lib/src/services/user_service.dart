part of 'services.dart';

class UserService {
  final usersCollection =
      FirebaseFirestore.instance.collection(usersCollectionName);

  Future<Either<String, UserModel>> registerWithEmail(
      {String? email, String? password, String? name}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      final userData = UserModel(
        admin: false,
        email: userCredential.user!.email,
        photoProfile: '',
        uid: userCredential.user!.uid,
        username: name,
      );

      usersCollection.doc(userCredential.user!.uid).set(userData.toMap());

      return right(userData);
    } on FirebaseAuthException catch (e) {
      return left(e.toString());
    }
  }
}
