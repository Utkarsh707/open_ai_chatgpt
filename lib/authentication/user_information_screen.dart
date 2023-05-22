import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_ai_chatgpt/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../service/assets_manager.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? finalImageFile;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    phoneController.text = authProvider.phoneNumber;
  }

  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();

  void selectImage(bool fromCamera) async {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 35.0),
              child: Column(
                children: [

                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.deepPurple,
                          backgroundImage: AssetImage(AssetsManager.userIcon),
                        ),
                        
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                border: Border.all(width: 2, color: Colors.white),
                                borderRadius: const BorderRadius.all(Radius.circular(35)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt, color: Colors.white,),
                                  onPressed: (){},
                                ),
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:  const EdgeInsets.only(top: 20),

                    child: Column(
                      children: [
                        myTextFormField(
                            hintText: 'Enter your name',
                            icon: Icons.account_circle,
                            textInputType: TextInputType.name,
                            maxLines: 1,
                            maxLength: 25,
                            textEditingController: nameController,
                            enabled: true,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        myTextFormField(
                          hintText: 'Enter your phone number',
                          icon: Icons.phone,
                          textInputType: TextInputType.number,
                          maxLines: 1,
                          maxLength: 10,
                          textEditingController: phoneController,
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RoundedLoadingButton(
                      controller: btnController,
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen()));
                      },
                      successIcon: Icons.check,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      color: Colors.deepPurple,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myTextFormField({
    required String hintText,
    required IconData icon,
    required TextInputType textInputType,
    required int maxLines,
    required int maxLength,
    required TextEditingController textEditingController,
    required bool enabled,
  }) {
    return TextFormField(
      enabled: enabled,
      cursorColor: Colors.orangeAccent,
      controller: textEditingController,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.deepPurple
          ),
          child: Icon(icon, size: 20, color: Colors.white,),
        ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        border: InputBorder.none,
        fillColor: Colors.purple.shade50,
        filled: true,

      ),
    );
  }
}
