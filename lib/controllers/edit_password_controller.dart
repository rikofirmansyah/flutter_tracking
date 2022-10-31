import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class EditPasswordController extends GetxController with StateMixin {
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final oldPassword = TextEditingController();

  GetStorage box = GetStorage();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(box.read('oldPass'));
    change(null, status: RxStatus.empty());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    confirmPasswordController.dispose();
    newPasswordController.dispose();
    oldPassword.dispose();
  }

  Future<void> firebaseChangePassword() async {
    change(null, status: RxStatus.loading());

    try {
      if (oldPassword.text == box.read('oldPass') &&
          newPasswordController.text == confirmPasswordController.text) {
        user!.updatePassword(newPasswordController.text.trim()).then(
              (value) => {
                box.write('oldPass', newPasswordController.text.trim()),
                change(null, status: RxStatus.success()),
                Get.snackbar('Success', 'Password berhasil diubah',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white),
                confirmPasswordController.clear(),
                newPasswordController.clear(),
                oldPassword.clear(),
              },
            );
      } else if (newPasswordController.text != confirmPasswordController.text) {
        change(null, status: RxStatus.error());
        Get.snackbar('Error', 'Password dan konfirmasi password tidak sama',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Password lama salah',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        change(null, status: RxStatus.error('Wrong Password'));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
