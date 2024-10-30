import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nvp_test/controllers/register_controller.dart';
import 'package:nvp_test/model/register_model.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/maps/maps_page.dart';
import 'package:nvp_test/views/widgets/custom_button.dart';
import 'package:nvp_test/views/widgets/password_form.dart';
import 'package:nvp_test/views/widgets/text_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final RegisterController controller = Get.put(RegisterController());
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
                        Text(AppLocalizations.of(context)?.joinNow ?? '',
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
                              TextForm(
                                  textEditingController: _nameController,
                                  messageValidation: controller.nameValidation,
                                  text: 'Name'),
                              PasswordForm(
                                  showPassword: controller.showPassword,
                                  textEditingController: _passwordController,
                                  messageValidation:
                                      controller.passwordValidation,
                                  text: 'Password'),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                label: AppLocalizations.of(context)
                                        ?.selectLocation ??
                                    '',
                                backgroundColor: thirdColor,
                                onPressed: () async {
                                  LatLng? selectedLocation =
                                      await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MapsPage()),
                                  );

                                  if (selectedLocation != null) {
                                    controller.selectedLocation.value = LatLng(
                                        selectedLocation.latitude,
                                        selectedLocation.longitude);
                                  }
                                },
                              ),
                              Obx(
                                () => controller.selectedLocation.value != null
                                    ? Center(
                                        child: Text(
                                          "${controller.selectedLocation.value!.latitude}, ${controller.selectedLocation.value!.longitude}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Obx(() => controller.locationValidation.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      controller.locationValidation.value,
                                      style: const TextStyle(color: Colors.red),
                                    )),
                              const SizedBox(
                                height: 15,
                              ),
                              Obx(
                                () => CustomButton(
                                  label:
                                      AppLocalizations.of(context)?.register ??
                                          '',
                                  backgroundColor: primaryColor,
                                  loading: controller.isSubmitted.value,
                                  onPressed: () {
                                    controller.register(
                                        data: RegisterModel(
                                            email: _emailController.text,
                                            name: _nameController.text,
                                            password: _passwordController.text,
                                            latitude: controller
                                                .selectedLocation
                                                .value
                                                ?.latitude,
                                            longitude: controller
                                                .selectedLocation
                                                .value
                                                ?.longitude));
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                      text: AppLocalizations.of(context)
                                              ?.alreadyHaveAnAccount ??
                                          '',
                                      style:
                                          const TextStyle(color: textSecondary),
                                      children: [
                                        TextSpan(
                                            text: AppLocalizations.of(context)
                                                    ?.login ??
                                                '',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.back();
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
