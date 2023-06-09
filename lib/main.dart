import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/model/user_model.dart';
import 'package:mytest/view/sign_in.dart';
import 'package:mytest/view/sign_up.dart';

import 'controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => MainPage(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpPage(),
        ),
        GetPage(
          name: '/signin',
          page: () => SignInPage(),
        ),
      ],
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => AuthController.curUser[0] == null
                ? TextButton(
                    onPressed: () {
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    ))
                : Text(
                    AuthController.curUser[0]?.displayName as String
                  )),
            Obx(() => AuthController.curUser[0] == null
                ? TextButton(
                    onPressed: () {
                      Get.toNamed('/signin');
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      AuthController.instance.logout();
                    },
                    child: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
