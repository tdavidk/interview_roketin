part of 'service.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final currentUser = FirebaseAuth.instance.currentUser;

class PersonService {
  static String? userUid;

  static Future signUp({
    required String username,
    required String password,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        Person person = Person(
          idUser: user.uid,
          username: username,
          password: password,
          email: email,
          phoneNumber: phoneNumber,
        );

        await PersonController().updatePerson(person);

        return SignInSignUpResult(person: person);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return SignInSignUpResult(message: "password terlalu mudah");
      } else if (e.code == 'email-already-in-use') {
        return SignInSignUpResult(message: "Email sudah terpakai");
      }
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        Person person = Person(
          idUser: user.uid,
          password: password,
          phoneNumber: "",
          username: "",
          email: email,
        );

        if (userCredential.additionalUserInfo?.isNewUser == true) {
          return SignInSignUpResult(message: "new_user");
        } else {
          Person personResult = await PersonController().getPerson(person);

          return SignInSignUpResult(person: personResult);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return SignInSignUpResult(message: "Email belum terdaftar");
      } else if (e.code == 'wrong-password') {
        return SignInSignUpResult(message: "Kata sandi salah");
      } else if (e.code == 'account-exists-with-different-credential') {
        return SignInSignUpResult(
            message:
                "Akun sudah terdaftar!\n jika akun anda, anda dapat mengubah password dari lupa password");
      }
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split('] ')[1]);
    }
  }

  static Future signInWithGoogle({required BuildContext context}) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {
          Person person = Person(
            idUser: user.uid,
            username: user.displayName ?? "",
            password: "password",
            phoneNumber: "081234567",
            email: user.email ?? "",
          );
          if (userCredential.additionalUserInfo?.isNewUser == true) {
            await PersonController().updatePerson(person);

            return SignInSignUpResult(person: person);
          } else {
            Person personResult = await PersonController().getPerson(person);

            return SignInSignUpResult(person: personResult);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return SignInSignUpResult(message: e.toString().split(']')[1]);
        } else if (e.code == 'invalid-credential') {
          return SignInSignUpResult(message: e.toString().split(']')[1]);
        }
      } catch (e) {
        return SignInSignUpResult(message: "error");
      }
    }
  }

  static Future<SignInSignUpResult?> signOut() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      if (!kIsWeb) {
        await auth.signOut();
      }
      await googleSignIn.signOut();

      return SignInSignUpResult(message: "signOut");
    } catch (e) {
      return SignInSignUpResult(message: "Error Logout");
    }
  }
}
