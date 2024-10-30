class EditProfileModel {
  String? name;
  double? latitude;
  double? longitude;

  EditProfileModel({this.name, this.latitude, this.longitude});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
