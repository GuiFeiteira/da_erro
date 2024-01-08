import 'package:da_erro/autentificacao/login_screen.dart';
import 'package:da_erro/userPreferences/current_user.dart';
import 'package:da_erro/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {

  final CurrentUser currentUser =Get.put(CurrentUser());

  signOut() async{
    var resultResp = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),

        ),
        content: Text(
          "Tens a certeza que queres sair?",

        ),
        actions: [
          TextButton(
              onPressed: (){
                Get.back();
          },
              child: Text(
                "Não",
                style: TextStyle(
                color: Colors.black,
              ),
            )
          ),
          TextButton(
              onPressed: (){
                Get.back(result: "Saiu com sucesso");
              },
              child: Text(
                "Sim",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),
        ],
      ),
    );
    if(resultResp == "Saiu com sucesso"){
      RememberPrefs.removerUser().then((value) {
        Get.off(LoginScreen());
      });
    }
  }

  Widget userInfoProf(IconData iconData, String userData){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        vertical: 8,
      ),
      child:  Row(
        children: [
          Icon(
              iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(height: 20,),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        Center(
          child: Image.asset(
            "images/boy.png",
            width: 150
          ),
        ),
        const SizedBox(height: 20,),
        userInfoProf(Icons.person, '   ' + currentUser.user.nome),
        const SizedBox(height: 20,),
        userInfoProf(Icons.email, '   ' + currentUser.user.email),
        const SizedBox(height: 20,),

        Center(
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: (){
                signOut();
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12
                ),
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,

                  ),
                ),
              ),
            ),
          ),
        )
      ],

    );
  }
}
