import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_password_controller.dart';

import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<EditPasswordController>();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditPasswordController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () =>
              Get.back(), // Get.off(AppPages.home, arguments: HomeArguments()),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password lama",
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) {
                      final isVisible = true.obs;
                      return Obx(
                        () => TextField(
                          obscureText: isVisible.value,
                          controller: controller.oldPassword,
                          decoration: InputDecoration(
                            suffixIcon: isVisible.value
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  ),
                            hintText: '********',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ).paddingAll(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password baru",
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) {
                      final isVisible = true.obs;
                      return Obx(
                        () => TextField(
                          obscureText: isVisible.value,
                          controller: controller.newPasswordController,
                          decoration: InputDecoration(
                            suffixIcon: isVisible.value
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  ),
                            hintText: '********',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ).paddingAll(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Konfirmasi password baru",
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) {
                      final isVisible = true.obs;
                      return Obx(
                        () => TextField(
                          controller: controller.confirmPasswordController,
                          obscureText: isVisible.value,
                          decoration: InputDecoration(
                            suffixIcon: isVisible.value
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () => {
                                      isVisible.toggle(),
                                    },
                                  ),
                            hintText: '********',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ).paddingAll(10),
              controller.obx(
                (state) => editPasswordButton(controller).paddingAll(10),
                onEmpty: editPasswordButton(controller).paddingAll(10),
                onLoading: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                onError: (err) => editPasswordButton(controller).paddingAll(10),
              ),
            ],
          ).paddingAll(20),
        ],
      ),
    );
  }

  Widget editPasswordButton(EditPasswordController controller) {
    return ElevatedButton(
      onPressed: () async {
        controller.firebaseChangePassword();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size(Get.width, 50)),
        backgroundColor: MaterialStateProperty.all(Color(0xff1E90FF)),
      ),
      child: Text(
        'Ubah Password',
      ),
    );
  }
}
