import 'package:abha_api/Bloc/Abha_bloc.dart';
import 'package:abha_api/Bloc/Abha_event.dart';
import 'package:abha_api/Bloc/Abha_state.dart';
import 'package:abha_api/Repository/repo.dart';
import 'package:abha_api/otp/verfiy_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';

class AadhaarLoginPage extends StatefulWidget {
  const AadhaarLoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AadhaarLoginPageState createState() => _AadhaarLoginPageState();
}

class _AadhaarLoginPageState extends State<AadhaarLoginPage> {
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isAadhaarLogin = true; // Toggle between Aadhaar and phone login
  Logger log = Logger();

  @override
  Widget build(BuildContext context) {
    final authRepository =
        AbhaRepository(baseUrl: Uri.parse('')); // Replace with valid URL

    return BlocProvider<AbhaBloc>(
      create: (context) => AbhaBloc(abhaRepository: authRepository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login with Aadhaar or Phone"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AbhaBloc, AbhaState>(
            listener: (context, state) {
              if (state is AadhaarOtpGenerated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Aadhaar OTP generated")),
                );
                log.d("$AadhaarOtpGenerated");
              } else if (state is PhoneOtpGenerated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Phone OTP generated")),
                );
                log.d("$PhoneOtpGenerated");
              } else if (state is AbhaError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                log.d("$state.message");
              }
            },
            builder: (context, state) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text("Aadhaar"),
                          selected: isAadhaarLogin,
                          onSelected: (selected) {
                            setState(() {
                              isAadhaarLogin = true;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text("Phone"),
                          selected: !isAadhaarLogin,
                          onSelected: (selected) {
                            setState(() {
                              isAadhaarLogin = false;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (isAadhaarLogin)
                      Pinput(
                        controller: aadhaarController,
                        length: 12, // Set to 12 digits for Aadhaar
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly // Only allow numeric input
                        ],
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        onChanged: (value) {
                          if (value.length == 12) {
                            print("Aadhaar number complete");
                          }
                        },
                      ),
                    if (!isAadhaarLogin)
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: "Enter Phone Number",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final authBloc = context.read<AbhaBloc>();
                        if (isAadhaarLogin) {
                          authBloc.add(
                            GenerateAadhaarOtpEvent(
                              aadhaarNumber: aadhaarController.text,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpVerificationPage(
                                    abhaRepository: authRepository)),
                          );
                        } else {
                          authBloc.add(
                            GeneratePhoneOtpEvent(
                              phonenumber: phoneController.text,
                            ),
                          );
                        }
                      },
                      child: const Text("Generate OTP"),
                    ),
                    const SizedBox(height: 20),
                    if (state is AbhaLoading) const CircularProgressIndicator(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
