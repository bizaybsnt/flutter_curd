class Validator {
  static String validatePassword(String value) {
    return value.isNotEmpty ? null : "This field can't be empty";
  }

  static String validatePhoneNumber(String value){
    String status = validateEmpty(value);
    if(status != null) return status;
    int number = int.tryParse(value);
    if(number == null) return "Enter valid phone number";
    return  value.length <= 10 ? null : "Mobile number must be 10 digit or less" ;
  }

  static String validateConfirmPassword(String value, String password) {
    return value == password ? null : "This does not match with password";
  }

  static String validateEmpty(String value) {
    return value.isNotEmpty ? null : "This field can't be empty";
  }
}
