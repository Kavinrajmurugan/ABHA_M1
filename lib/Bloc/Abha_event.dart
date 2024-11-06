import 'package:equatable/equatable.dart';

abstract class AbhaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateAadhaarOtpEvent extends AbhaEvent {
  final String aadhaarNumber;

  GenerateAadhaarOtpEvent({required this.aadhaarNumber});

  @override
  List<Object?> get props => [aadhaarNumber];
}

class VerifyPhoneNumberEvent extends AbhaEvent {
  final String phonenumber;

  VerifyPhoneNumberEvent({required this.phonenumber});

  @override
  List<Object?> get props => [phonenumber];
}

class GeneratePhoneOtpEvent extends AbhaEvent {
  final String phonenumber;

  GeneratePhoneOtpEvent({required this.phonenumber});

  @override
  List<Object?> get props => [phonenumber];
}

class AadhaarSubmitEvent extends AbhaEvent {
  final String aadhaarNumber;

  AadhaarSubmitEvent(this.aadhaarNumber);
}

class OtpVerificationEvent extends AbhaEvent {
  final String otp;
  OtpVerificationEvent(this.otp);
}

class OtpSubmitted extends AbhaEvent {
  final String otp;

  OtpSubmitted(this.otp);

  @override
  List<Object> get props => [otp];
}
