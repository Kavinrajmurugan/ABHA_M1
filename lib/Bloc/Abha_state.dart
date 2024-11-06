abstract class AbhaState {}

class AbhaInitial extends AbhaState {}

class AbhaLoading extends AbhaState {}

class AadhaarOtpGenerated extends AbhaState {}

class PhoneOtpGenerated extends AbhaState {}

class AadhaarSubmittedState extends AbhaState {}

class OtpVerificationSuccess extends AbhaState {}

class OtpVerificationFailure extends AbhaState {
  final String error;
  OtpVerificationFailure(this.error);
}

class AbhaError extends AbhaState {
  final String message;
  AbhaError(this.message);
}
