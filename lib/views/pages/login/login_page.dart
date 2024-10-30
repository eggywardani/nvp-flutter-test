import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:nvp_test/controllers/login_controller.dart';
import 'package:nvp_test/model/login_model.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/register/register_page.dart';
import 'package:nvp_test/views/widgets/custom_button.dart';
import 'package:nvp_test/views/widgets/password_form.dart';
import 'package:nvp_test/views/widgets/text_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController controller = Get.put(LoginController());
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 0.8,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.89),
                      Theme.of(context).primaryColor,
                    ],
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                            AppLocalizations.of(context)?.signInToYourAccount ??
                                '',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 34,
                              ),
                              TextForm(
                                  textEditingController: _emailController,
                                  messageValidation: controller.emailValidation,
                                  text: 'Email'),
                              PasswordForm(
                                  showPassword: controller.showPassword,
                                  textEditingController: _passwordController,
                                  messageValidation:
                                      controller.passwordValidation,
                                  text: 'Password'),
                              const SizedBox(
                                height: 15,
                              ),
                              Obx(
                                () => CustomButton(
                                  label:
                                      AppLocalizations.of(context)?.login ?? '',
                                  backgroundColor: primaryColor,
                                  loading: controller.isSubmitted.value,
                                  onPressed: () {
                                    controller.login(
                                        data: LoginModel(
                                            email: _emailController.text,
                                            password:
                                                _passwordController.text));
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                      text: AppLocalizations.of(context)
                                              ?.dontHaveAnAccount ??
                                          '',
                                      style:
                                          const TextStyle(color: textSecondary),
                                      children: [
                                        TextSpan(
                                            text: AppLocalizations.of(context)
                                                    ?.register ??
                                                '',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.to(const RegisterPage());
                                              },
                                            style: const TextStyle(
                                                color: primaryColor))
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
