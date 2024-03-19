class AppUrl {
  static var baseUrl = 'http://localhost:3000';
  static var sendOTP = '$baseUrl/api/sendEmail-otp';
  static var sendOTPForgotPassword =
      '$baseUrl/api/sendEmail-forgotPassword-otp';
  static var verifyOTP = '$baseUrl/api/verify-otp';
  static var signupUrl = '$baseUrl/api/signup';
  static var loginUrl = '$baseUrl/api/signin';
  static var getUser = '$baseUrl/tokenIsValid';
  static var getUserData = '$baseUrl/';
  static var getUserOnlyData = '$baseUrl/userData';
  static var forgotPassword = '$baseUrl/api/forgotpassword';
}
