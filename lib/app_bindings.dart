
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'controllers/preference_controller.dart';
import 'package:movies_task/utils/app_consts.dart';
import 'package:movies_task/models/network_client.dart';

BindingsBuilder createBindings(BuildContext context) {
  return BindingsBuilder(() {
    Get.put<NetworkClient>(
      NetworkClient(
        getUserAuthToken: () async {
          final auth = AppConsts.appToken;
          return auth;
        },
      ),
      permanent: true,
    );
    Get.put<AppPreferencesController>(
      AppPreferencesController(),
      permanent: true,
    );
  });
}
