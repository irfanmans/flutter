// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subproject1/database/db_helper_user.dart';
import 'package:subproject1/models/user.dart';
import 'package:subproject1/screens/home_screen.dart';
import 'package:subproject1/style/app_color.dart';
import 'package:subproject1/widgets/custom_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  String resultValidasiEmail = "";
  String resultValidasiPassword = "";
  String loginError = "";

  DatabaseUserHelper databaseUserHelper = DatabaseUserHelper();

  void validasiEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        resultValidasiEmail = "";
      });
    } else if (value.contains("@") && value.length > 5) {
      setState(() {
        resultValidasiEmail = "email anda valid";
      });
    } else {
      setState(() {
        resultValidasiEmail = "email anda tidak valid";
      });
    }
  }

  void validasiPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        resultValidasiPassword = "";
      });
    } else if (value.length > 5) {
      setState(() {
        resultValidasiPassword = "password anda Valid";
      });
    } else {
      setState(() {
        resultValidasiPassword = "password anda tidak valid";
      });
    }
  }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    User? isLogin = await databaseUserHelper.loginUser(email, password);

    if (isLogin != null) {
      setState(() {
        loginError = "";
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Login Gagal"),
            content: const Text("Email atau password salah!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          child: Image(
            image: AssetImage("assets/images/imageLogin.png"),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 35,
          top: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Silahkan Login",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Selamat datang semoga hari anda \nmenyenangkan",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.abuAbuMuda,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 300,
            left: 35,
            right: 35,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: emailController,
                  onChanged: (value) {
                    validasiEmail(value);
                  },
                  hintText: "Masukkan Email Anda",
                  labelText: "Email",
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColors.abuAbuTua,
                    size: 20,
                  ),
                ),
                resultValidasiEmail == ""
                    ? const SizedBox(height: 0)
                    : const SizedBox(height: 5),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(resultValidasiEmail),
                ),
                CustomTextField(
                  controller: passwordController,
                  onChanged: (value) {
                    validasiPassword(value);
                  },
                  hintText: "Masukkan Password Anda",
                  labelText: 'Password',
                  obscureText: isPasswordVisible ? false : true,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.abuAbuTua,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    color: AppColors.abuAbuTua,
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.remove_red_eye_sharp
                          : Icons.visibility_off,
                      size: 20,
                    ),
                  ),
                ),
                resultValidasiPassword == ""
                    ? const SizedBox(height: 0)
                    : const SizedBox(height: 5),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(resultValidasiPassword),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // await login();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1559B7),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                    ),
                    child: Text(
                      "Masuk",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  loginError,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
