import 'package:contodo/file_exporter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contodo/ui/views/splash/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

@lazySingleton
class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  // Login with Email and Password
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _localStorageService.write('token', userCredential.user?.uid);
      print(userCredential.user!.email);
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>?> getUserData(String token) async {
    try {
      final doc = await _firestore.collection('users').doc(token).get();
      if (doc.exists) {
        return doc.data(); // Return user data if found
      } else {
        return null; // User not found
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  // Signup with Email and Password
  Future<User?> signup(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Store user info in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'uid': userCredential.user?.uid,
        'email': email,
        'name': name,
        'createdAt': DateTime.now(),
      });
      _localStorageService.write('token', userCredential.user?.uid);
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Forget Password
  Future<void> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      _localStorageService.clear();
      _navigationService.clearStackAndShow(Routes.loginView);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Check if token exists
  bool isUserLoggedIn() {
    bool isValid = _localStorageService.read('token') != null ? true : false;

    return isValid;
  }
}
