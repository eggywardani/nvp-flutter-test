import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nvp_test/controllers/edit_profile_controller.dart';
import 'package:nvp_test/model/edit_profile_model.dart';
import 'package:nvp_test/theme/app_color.dart';
import 'package:nvp_test/views/pages/maps/maps_page.dart';
import 'package:nvp_test/views/widgets/custom_button.dart';
import 'package:nvp_test/views/widgets/text_form.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.data});
  final EditProfileModel data;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.data.name ?? '';
    controller.selectedLocation.value =
        LatLng(widget.data.latitude ?? 0.0, widget.data.longitude ?? 0);
  }

  @override
  void dispose() {
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
                        Text(AppLocalizations.of(context)?.editProfile ?? '',
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
                                  textEditingController: _nameController,
                                  messageValidation: controller.nameValidation,
                                  text: 'Name'),
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
                                  label: AppLocalizations.of(context)
                                          ?.updateProfile ??
                                      '',
                                  backgroundColor: primaryColor,
                                  loading: controller.isSubmitted.value,
                                  onPressed: () {
                                    controller.updateProfile(
                                        data: EditProfileModel(
                                            name: _nameController.text,
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
