import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class QrcodeFirebaseUser {
  QrcodeFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

QrcodeFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<QrcodeFirebaseUser> qrcodeFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<QrcodeFirebaseUser>((user) => currentUser = QrcodeFirebaseUser(user));
