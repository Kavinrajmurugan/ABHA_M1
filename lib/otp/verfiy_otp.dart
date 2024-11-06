import 'package:abha_api/Bloc/Abha_bloc.dart';
import 'package:abha_api/Bloc/Abha_event.dart';
import 'package:abha_api/Bloc/Abha_state.dart';
import 'package:abha_api/Repository/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatelessWidget {
  final AbhaRepository abhaRepository;
  Logger log = Logger();

  OtpVerificationPage({super.key, required this.abhaRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AbhaBloc(abhaRepository: abhaRepository),
      child: Scaffold(
        appBar: AppBar(title: const Text('OTP Verification')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocListener<AbhaBloc, AbhaState>(
                  listener: (context, state) {
                    if (state is OtpVerificationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("OTP Verified!")),
                      );
                    } else if (state is OtpVerificationFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    } else if (state is AadhaarOtpGenerated ||
                        state is PhoneOtpGenerated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("OTP Resent! Check your phone.")),
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter the OTP sent to your phone',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        onCompleted: (otp) {
                          if (otp.length == 6) {
                            context
                                .read<AbhaBloc>()
                                .add(OtpVerificationEvent(otp));
                            log.d("OTP Submitted: $otp");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please enter a valid 6-digit OTP"),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<AbhaBloc, AbhaState>(
                        builder: (context, state) {
                          return state is AbhaLoading
                              ? const CircularProgressIndicator()
                              : InkWell(
                                  child: const Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    // Trigger the event to resend OTP (e.g., GenerateAadhaarOtpEvent or GeneratePhoneOtpEvent)
                                    context.read<AbhaBloc>().add(
                                        GenerateAadhaarOtpEvent(
                                            aadhaarNumber:
                                                '')); // Replace with actual Aadhaar or phone number
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
