import 'package:get/get.dart';

class PasswordController extends GetxController {

  RxBool isObscure = true.obs;
  RxBool isConfirmObscure = true.obs;


  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }
  void toggleConfirmObscure() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }
}
