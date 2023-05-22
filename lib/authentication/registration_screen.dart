import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_ai_chatgpt/authentication/otp_screen.dart';
import 'package:open_ai_chatgpt/providers/authentication_provider.dart';
import 'package:open_ai_chatgpt/service/assets_manager.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: '+91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
  );

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    phoneController.dispose();
    btnController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   phoneController.selection = TextSelection.fromPosition(
       TextPosition(
           offset: phoneController.text.length),
   );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 35.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(90)),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(AssetsManager.openAILogo),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Add your phone number- I will send you a verification code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    maxLength: 10,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        hintText: 'Enter phone number',
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.orangeAccent),
                        ),
                        prefixIcon: Container(
                        padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 500),
                              onSelect: (value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },
                            );
                          },
                          child: Text(
                            '${selectedCountry.flagEmoji}+${selectedCountry.phoneCode}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ),
                      suffixIcon: phoneController.text.length > 9 ? Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green
                        ),
                        child: const Icon(Icons.done, size: 20, color: Colors.white),
                      ) : null
                        ),
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
                        sendPhoneNumber();
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

  void sendPhoneNumber() {
    final authRepo = Provider.of<AuthenticationProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    String fullPhoneNumber = '+${selectedCountry.phoneCode}${phoneNumber}';
    
    authRepo.signInWithPhone(context: context, phoneNumber: fullPhoneNumber, btnController: btnController);
  }
}
