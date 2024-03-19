class AppUrl {
  static var baseUrl = 'https://localhost:8082';
  static var sendOTP = '$baseUrl/api/account/sendEmail-otp';
  static var sendOTPForgotPassword =
      '$baseUrl/api/account/sendEmail-forgotPassword-otp';
  static var verifyOTP = '$baseUrl/api/account/verify-otp';
  static var signupUrl = '$baseUrl/api/account/signup';
  static var loginUrl = '$baseUrl/UserAPI/api/account/login';
  static var getUser = '$baseUrl/tokenIsValid';
  static var getUserData = '$baseUrl/CustomerAPI/api/User/myprofile';
  static var getUserOnlyData = '$baseUrl/userData';
  static var forgotPassword = '$baseUrl/api/forgotpassword';
}
