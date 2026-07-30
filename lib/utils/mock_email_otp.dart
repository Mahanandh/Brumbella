import 'dart:math';
import 'package:flutter/material.dart';

enum OTPType { digitsOnly, alphanumeric }

class MockEmailOTP {
  String? _appEmail;
  String? _appName;
  String? _userEmail;
  int _otpLength = 6;
  OTPType _otpType = OTPType.digitsOnly;

  String? _generatedOtp;

  void setConfig({
    required String appEmail,
    required String appName,
    required String userEmail,
    int otpLength = 6,
    OTPType otpType = OTPType.digitsOnly,
  }) {
    _appEmail = appEmail;
    _appName = appName;
    _userEmail = userEmail;
    _otpLength = otpLength;
    _otpType = otpType;
  }

  Future<bool> sendOTP() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate OTP
    final random = Random();
    String otp = '';
    for (int i = 0; i < _otpLength; i++) {
      otp += random.nextInt(10).toString();
    }
    _generatedOtp = otp;

    // Simulate sending email by printing to console
    print('====================================================');
    print('MOCK EMAIL OTP SENT TO: $_userEmail');
    print('FROM: $_appName <$_appEmail>');
    print('YOUR OTP CODE IS: $_generatedOtp');
    print('====================================================');

    // In a real scenario, this returns true if HTTP success
    return true;
  }

  Future<bool> verifyOTP({required String otp}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return otp == _generatedOtp;
  }
}
