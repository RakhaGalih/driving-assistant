import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sdla/components/appbar.dart';
import 'package:sdla/components/button.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/services/http_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  String error = "";
  bool _showSpinner = false;

  Future<void> _signUp() async {
    if (passwordController.text == confirmPasswordController.text) {
      setState(() {
        _showSpinner = true;
      });
      Map<String, dynamic> response = {};
      try {
        Map<String, dynamic> data = {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        };
        response = await postData("/api/admin/registerakun", data);
        print('berhasil daftar!');
        await _login();
        print('berhasil login!');
      } catch (e) {
        print(response);
        setState(() {
          _showSpinner = false;
          error = "Akun tersebut sudah ada";
        });
        print('Register error: $e');
      }
      setState(() {
        _showSpinner = false;
      });
    } else {
      print('sigma');
      setState(() {
        error = "password tidak dapat dikonfirmasi";
      });
    }
  }

  Future<void> _login() async {
    Map<String, dynamic> response = {};
    try {
      Map<String, dynamic> data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      response = await postData("/api/admin/login", data);
      token = response['token']; // Ambil token dari response

      print('berhasil login!');
    } catch (e) {
      error = "${response['email'][0]}\n${response['password'][0]}";
      setState(() {});
      print('Login error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: kBlue,
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                children: [
                  const BackGroundAppBar(),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: height,
                      color: kWhite,
                      padding: const EdgeInsets.symmetric(
                          vertical: 45, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: nameController,
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Username'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: emailController,
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Email'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: _isObscure,
                            decoration: kTextFieldInputDecoration.copyWith(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    child: Icon(
                                      (_isObscure)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: kGreyText,
                                    ))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: _isObscure,
                            decoration: kTextFieldInputDecoration.copyWith(
                                hintText: 'Konfirmasi Password',
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    child: Icon(
                                      (_isObscure)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: kGreyText,
                                    ))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SecondaryButton(
                              title: 'Sign Up',
                              onTap: () async {
                                await _signUp();
                              }),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            error,
                            textAlign: TextAlign.center,
                            style: kSemiBoldTextStyle.copyWith(
                                color: const Color(0xFFCD1A1A)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
