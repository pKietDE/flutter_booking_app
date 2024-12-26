class MyRegex {
  // *Kiểm tra email hợp lệ
  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return false; // todo: Trả về false nếu email null hoặc rỗng
    }
    final RegExp regex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  // *Kiểm tra mật khẩu hợp lệ
  static bool isValidPassword(String? pass) {
    if (pass == null || pass.isEmpty) {
      return false; // todo: Trả về false nếu mật khẩu null hoặc rỗng
    }
    final RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(pass);
  }
}
