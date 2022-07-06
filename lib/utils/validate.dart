
class ValidateEmail {
  bool isValidEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }
}

class ValidatePhone {
  bool isValidPhone(String value) {
    RegExp regex = RegExp(r'(^(?:[0]8)?[0-9]{9,11}$)');

    if (value.isEmpty) {
      return false;
    } else if (!regex.hasMatch(value)) {
      return false;
    }
    return true;
  }
}

class LengthPassword{
  bool minChar(String value){
    if (value.length < 6) {
      return false;
    }else{
      return true;
    }
  }
}
