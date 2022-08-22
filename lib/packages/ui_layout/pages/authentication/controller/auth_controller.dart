import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_clear_19/packages/business_layout/lib/business_layout.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../home_page/home_page.dart';
import '../views/login_page.dart';

class AuthController extends GetxController {
  //AuthController.instance
  static AuthController instance = Get.find<AuthController>();

  //email, password, name ...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSign = GoogleSignIn();
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    //для прослушивания
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    //для прослушивания
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _initialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => LoginView());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      //сюда можно передвать данные пользователя из базы
      Get.offAll(() => MyHomePage(email: user.email));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar(
        "Register error $firebaseAuthException",
        firebaseAuthException.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(firebaseAuthException.toString());
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar(
        "Login error $firebaseAuthException",
        firebaseAuthException.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(firebaseAuthException.toString());
    }
  }

  void logOut() async {
    await auth.signOut();
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => LoginView());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.find<AbstractMainGetXStateManagement>();
      Get.offAll(() => MyHomePage(email: googleSignInAccount.email));
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error $e",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }
}
