import 'package:flutter/material.dart';
import 'package:sdla/components/appbar.dart';
import 'package:sdla/components/button.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/screens/auth/signup.dart';
import 'package:sdla/screens/home/home.dart';
import 'package:sdla/services/http_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  String error = "";

  Future<void> _login() async {
    error = "";
    setState(() {});
    Map<String, dynamic> response = {};
    try {
      Map<String, dynamic> data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      response = await postData("/api/admin/login", data);
      token = response['token']; // Ambil token dari response
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
      print('berhasil login!');
    } catch (e) {
      setState(() {
        error = "Email atau Password salah";
      });
      error = "${response['email'][0]}\n${response['password'][0]}";
      print('Login error: $e');
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
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
                        MainButton(
                          title: 'Sign In',
                          onTap: () async {
                            await _login();
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          textAlign: TextAlign.center,
                          style: kSemiBoldTextStyle.copyWith(
                              color: const Color(0xFFCD1A1A)),
                        ),
                        /*
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/signIn');
                          },
                          child: Text(
                            'Lupa password',
                            style: kMediumTextStyle.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: kBlue,
                                fontSize: 14,
                                color: kBlue),
                          ),
                        ),*/
                        const Spacer(),
                        Text(
                          'Belum punya akun?',
                          style: kMediumTextStyle.copyWith(
                              fontSize: 14, color: kGreyText),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SecondaryButton(
                            title: 'Sign Up',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
