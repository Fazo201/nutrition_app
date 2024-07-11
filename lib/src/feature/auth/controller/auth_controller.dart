import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_go_router_flutter_localizations_inherited_widget/src/core/routes/app_route_name.dart';
import 'package:provider_go_router_flutter_localizations_inherited_widget/src/core/style/colors.dart';
import 'package:provider_go_router_flutter_localizations_inherited_widget/src/core/utils/utils.dart';
import 'package:provider_go_router_flutter_localizations_inherited_widget/src/models/auth_model.dart';
import 'package:provider_go_router_flutter_localizations_inherited_widget/src/repository/app_repository.dart';
import 'package:provider_go_router_flutter_localizations_inherited_widget/src/repository/app_repository_impl.dart';

class AuthController extends ChangeNotifier {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confirmNewPassC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    newPassC.dispose();
    confirmNewPassC.dispose();
  }

  /// For LogIn
  bool logInVisible = true;
  void logInVisibleFunc() {
    logInVisible = !logInVisible;
    notifyListeners();
  }

  /// For Register
  bool registerVisibility = true;
  void registerVisibilityFunc() {
    registerVisibility = !registerVisibility;
    notifyListeners();
  }

  void refresh({required String doYouWantToRefreshLoginOrRegister}) {
    doYouWantToRefreshLoginOrRegister == "l"
        ? logInVisible = true
        : registerVisibility = true;
    notifyListeners();
  }

  // Bekend bo'yicha

  final AppRepository repository = AppRepositoryImpl();
  AuthModel? authModel;

  Future<void> login(BuildContext context) async {
    authModel = await repository.postLogin(emailC.text, passwordC.text);
    // log(authModel.toString());
    // log(authModel?.name.toString()??"");
    // log(authModel?.email.toString()??"");
    log(authModel?.id.toString()??"");
    if (context.mounted && authModel != null) {
      emailC.clear();
      passwordC.clear();
      Utils.fireSnackBar(
        message: "Successfully Log In",
        context: context,
        backgroundColor: AppColors.c91C788,
      );
      context.go(AppRouteName.home);
    } else {
      Utils.fireSnackBar(
        message: "Error nimadir xato",
        context: context,
        backgroundColor: AppColors.cFF8473,
      );
    }
  }
}
