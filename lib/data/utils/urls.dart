class Urls {
  Urls._();

/*  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTasks = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String canceledTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static String completedTasks = '$_baseUrl/listTaskByStatus/Completed';

  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';

  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';

  static String updateProfile = '$_baseUrl/profileUpdate';
  static String sendOtpToEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpVerify(String email, String otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static String resetPassword = '$_baseUrl/RecoverResetPass';*/

  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static String registration = '$_baseUrl/Registration';
  static String login = '$_baseUrl/Login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTasks = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String canceledTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static String completedTasks = '$_baseUrl/listTaskByStatus/Completed';

  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';

  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';

  static String updateProfile = '$_baseUrl/ProfileUpdate';
  static String sendOtpToEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpVerify(String email, String otp) => '$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static String resetPassword = '$_baseUrl/RecoverResetPassword';


}