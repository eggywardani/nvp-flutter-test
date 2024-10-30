import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:nvp_test/controllers/account_controller.dart';
import 'package:nvp_test/controllers/language_controller.dart';
import 'package:nvp_test/controllers/theme_controller.dart';
import 'package:nvp_test/helpers/avatar.dart';
import 'package:nvp_test/model/edit_profile_model.dart';
import 'package:nvp_test/model/register_model.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/edit-profile/edit_profile_page.dart';
import 'package:nvp_test/views/widgets/loading_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());
    final ThemeController themeController = Get.put(ThemeController());
    final LanguageController languageController = Get.put(LanguageController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          AppLocalizations.of(context)?.account ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder<RegisterModel?>(
        stream: controller.getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // Check if the snapshot has data
          if (snapshot.hasData && snapshot.data != null) {
            // Access the `name` field from the RegisterModel
            RegisterModel data = snapshot.data;
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 25.0),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.primaries[4]),
                                    padding: const EdgeInsets.all(9),
                                    alignment: Alignment.center,
                                    child: Text(
                                      generateInitials(data.name ?? '-'),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${data.name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.person,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${data.name}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.envelope,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${data.email}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => Icon(
                                    themeController.isDarkMode.value
                                        ? Icons.nightlight_round
                                        : Icons.wb_sunny,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Obx(() => Text(
                                      themeController.isDarkMode.value
                                          ? AppLocalizations.of(context)
                                                  ?.darkTheme ??
                                              ''
                                          : AppLocalizations.of(context)
                                                  ?.lightTheme ??
                                              '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )),
                              ],
                            ),
                            Obx(() => CupertinoSwitch(
                                  value: themeController.isDarkMode.value,
                                  onChanged: (value) {
                                    themeController
                                        .toggleTheme(); // Toggle theme on switch
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Icon(
                                Icons.translate,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                Get.locale?.languageCode == 'id'
                                    ? AppLocalizations.of(context)?.indonesia ??
                                        ''
                                    : AppLocalizations.of(context)?.english ??
                                        '',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ]),
                            CupertinoSwitch(
                              value: Get.locale?.languageCode == 'id'
                                  ? true
                                  : false,
                              onChanged: (value) {
                                languageController.toggleLanguage();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => EditProfilePage(
                              data: EditProfileModel(
                                  name: data.name,
                                  latitude: data.latitude,
                                  longitude: data.longitude),
                            ));
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Icon(
                                Icons.account_box,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                AppLocalizations.of(context)?.editProfile ?? '',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ]),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    // Obx(
                    //   () => InkWell(
                    //     onTap: controller.isSubmittedButtonNotification.value
                    //         ? null
                    //         : () {
                    //             controller.sendNotification(
                    //                 title: "Don't Miss Out!",
                    //                 message:
                    //                     'If you receive this message, the notification system is working!');
                    //           },
                    //     child: Container(
                    //       width: Get.width,
                    //       padding: const EdgeInsets.symmetric(
                    //           vertical: 10, horizontal: 20),
                    //       decoration: BoxDecoration(
                    //         color: Theme.of(context).colorScheme.secondary,
                    //         border: Border.all(color: Colors.grey, width: 0.5),
                    //       ),
                    //       child: controller.isSubmittedButtonNotification.value
                    //           ? const Center(
                    //               child: SizedBox(
                    //                 width: 20,
                    //                 height: 20,
                    //                 child: CircularProgressIndicator(
                    //                   strokeWidth: 2,
                    //                 ),
                    //               ),
                    //             )
                    //           : Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Row(children: [
                    //                   const Icon(
                    //                     Icons.notification_add,
                    //                     color: primaryColor,
                    //                   ),
                    //                   const SizedBox(
                    //                     width: 10,
                    //                   ),
                    //                   Text(
                    //                     AppLocalizations.of(context)
                    //                             ?.sendNotification ??
                    //                         '',
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .titleSmall,
                    //                   ),
                    //                 ]),
                    //                 const Icon(
                    //                   Icons.arrow_forward_ios,
                    //                   size: 15,
                    //                 )
                    //               ],
                    //             ),
                    //     ),
                    //   ),
                    // ),
                    Obx(() => InkWell(
                          onTap: controller.isSubmittedButton.value
                              ? null
                              : () {
                                  controller.logout();
                                },
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: controller.isSubmittedButton.value
                                ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      const Icon(
                                        Icons.logout_outlined,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)?.logout ??
                                            '',
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                          ),
                        ))
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: double.infinity,
              child: loadingWidget(),
            );
          } else {
            return const SizedBox(
              width: double.infinity,
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
