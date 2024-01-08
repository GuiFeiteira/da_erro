import 'dart:convert';

import 'package:da_erro/autentificacao/login_screen.dart';
import 'package:da_erro/api/api_conect.dart';
import 'package:da_erro/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var pontos = true.obs;

  validaUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.validarEmail),
        body: {
          'email': email.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        var resposta = jsonDecode(res.body);
        if (resposta['emailEncontrado'] == true) {
          Fluttertoast.showToast(msg: "O Email Ja Esta A Ser Utilizado");
        } else {
          registarUser();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  registarUser() async {
    User userModel = User(1, name.text.trim(), email.text.trim(), password.text.trim());

    try {
      var res = await http.post(
        Uri.parse(API.signup),
        body: userModel.toJson(),
      );
      print("Response Body: ${res.body}");
      if (res.statusCode == 200) {
        var resposta = jsonDecode(res.body);
        if (resposta['success'] == true) {
          Fluttertoast.showToast(msg: 'Registo Realizado com Sucesso');
          setState(() {
            name.clear();
            email.clear();
            password.clear();
          });
        } else {
          Fluttertoast.showToast(msg: 'Erro No Registo');
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
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
          // Conteúdo do formulário

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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: name,
                              validator: (val)=> val == ""? "Por favor escreva o seu nome": null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black26,

                                ),

                                hintText: "Nome",

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                fillColor: Colors.white,
                                filled: true,


                              ),
                            ),
                            const SizedBox(height: 18,),


                            TextFormField(
                              controller: email,
                              validator: (val)=> val == ""? "Por favor escreva o seu email": null,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black26,

                                ),

                                hintText: "Email",

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color:  Colors.deepPurpleAccent,
                                    )
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                fillColor: Colors.white,
                                filled: true,


                              ),
                            ),

                            const SizedBox(height: 18,),

                            Obx(
                                    () => TextFormField(
                                  controller: password,
                                  obscureText: pontos.value,
                                  validator: (val)=> val == ""? "Por favor escreva a sua password": null,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.vpn_key ,
                                      color: Colors.black26,
                                    ),
                                    suffixIcon: Obx(
                                          ()=> GestureDetector(
                                          onTap: (){
                                            pontos.value = !pontos.value;
                                          },
                                          child: Icon(
                                            pontos.value ? Icons.visibility_off : Icons.visibility,
                                            color: Colors.black26,
                                          )


                                      ),

                                    ),
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:  Colors.deepPurpleAccent,
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:  Colors.deepPurpleAccent,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:  Colors.deepPurpleAccent,
                                        )
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:  Colors.deepPurpleAccent,
                                        )
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,


                                  ),
                                )),

                            const SizedBox(height: 18,),
                            Material(
                              color: Color(0xFF977AA3),
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: ()
                                {
                                  if(formKey.currentState!.validate()){
                                    validaUserEmail();
                                  }
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "Registar",
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
                          const Text("Já Tens Conta?"),
                          TextButton(
                            onPressed: () {
                              Get.to(LoginScreen());
                            },
                            child: const Text(
                              "Faz login Aqui !",
                              style: TextStyle(
                                color: Color(0xFF977AA3),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
