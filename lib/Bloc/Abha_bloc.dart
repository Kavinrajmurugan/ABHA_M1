// AbhaBloc

import 'package:abha_api/Bloc/Abha_event.dart';
import 'package:abha_api/Bloc/Abha_state.dart';
import 'package:abha_api/Repository/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbhaBloc extends Bloc<AbhaEvent, AbhaState> {
  final AbhaRepository abhaRepository;

  AbhaBloc({required this.abhaRepository}) : super(AbhaInitial()) {
    on<GenerateAadhaarOtpEvent>(_onGenerateAadhaarOtpEvent);
    on<GeneratePhoneOtpEvent>(_onGeneratePhoneOtpEvent);
    on<AadhaarSubmitEvent>(_onAadhaarSubmitEvent);
    on<OtpVerificationEvent>(_onOtpVerificationEvent);
  }

  void _onGenerateAadhaarOtpEvent(
      GenerateAadhaarOtpEvent event, Emitter<AbhaState> emit) async {
    emit(AbhaLoading());
    try {
      await abhaRepository.generateAadhaarOtp(event.aadhaarNumber);
      emit(AadhaarOtpGenerated());
    } catch (error) {
      emit(AbhaError("Failed to generate Aadhaar OTP: $error"));
    }
  }

  void _onGeneratePhoneOtpEvent(
      GeneratePhoneOtpEvent event, Emitter<AbhaState> emit) async {
    emit(AbhaLoading());
    try {
      await abhaRepository.generatePhoneOtp(event.phonenumber);
      emit(PhoneOtpGenerated());
    } catch (error) {
      emit(AbhaError("Failed to generate Phone OTP: $error"));
    }
  }

  void _onAadhaarSubmitEvent(
      AadhaarSubmitEvent event, Emitter<AbhaState> emit) async {
    emit(AbhaLoading());
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network call
      emit(AadhaarSubmittedState());
    } catch (error) {
      emit(AbhaError("Failed to submit Aadhaar: $error"));
    }
  }

  void _onOtpVerificationEvent(
      OtpVerificationEvent event, Emitter<AbhaState> emit) async {
    emit(AbhaLoading());
    try {
      final isVerified = await abhaRepository.verifyOtp(event.otp);
      if (isVerified) {
        emit(OtpVerificationSuccess());
      } else {
        emit(OtpVerificationFailure("Invalid OTP. Please try again."));
      }
    } catch (error) {
      emit(OtpVerificationFailure("Failed to verify OTP: $error"));
    }
  }
}
