part of 'widgets.dart';

class ToastAlert {
  void showToastWarningTop(String message) {
    Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
    );
  }

  void showToastWarningCenter(String message) {
    Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.red,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
    );
  }

  void showToastCenter(String message) {
    Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: AppColor.primary,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
    );
  }
}
