import 'dart:convert';

import 'package:da_erro/Paginas/dashboard.dart';
import 'package:da_erro/api/api_conect.dart';
import 'package:da_erro/autentificacao/signup_screen.dart';
import 'package:da_erro/model/user.dart';
import 'package:da_erro/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var pontos = true.obs;

  loginUser() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          'email': email.text.trim(),
          'password': password.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        var resposta = jsonDecode(res.body);

        if (resposta["success"] == true) {
          Fluttertoast.showToast(msg: 'Login Bem Sucedido');

          User userInfo = User.fromJson(resposta["userData"]);
          await RememberPrefs.saveUser(userInfo);
          Get.to(() => Dashboard());
        } else {
          Fluttertoast.showToast(msg: 'Email ou Password Errados');
        }
      }
    } catch (e) {
      print("Erro," + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/Delay.png",
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment(0.0, -0.7),
            child: Image.asset(
              "images/logo.png",
              width: 100,
              height: 100,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: Color(0xFFDACEB9).withOpacity(0.85),
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: email,
                              validator: (val) =>
                              val == "" ? "Por favor escreva o seu email" : null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black26,
                                ),
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Obx(
                                  () => TextFormField(
                                controller: password,
                                obscureText: pontos.value,
                                validator: (val) =>
                                val == "" ? "Por favor escreva a sua password" : null,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key_sharp,
                                    color: Colors.black26,
                                  ),
                                  suffixIcon: Obx(() => GestureDetector(
                                    onTap: () {
                                      pontos.value = !pontos.value;
                                    },
                                    child: Icon(
                                      pontos.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black26,
                                    ),
                                  )),
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Material(
                              color:  Color(0xFF977AA3),
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    loginUser();
                                  }
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Ainda Não Tens Conta?"),
                          TextButton(
                            onPressed: () {
                              Get.to(SignUpScreen());
                            },
                            child: const Text(
                              "Regista-te Aqui !",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

