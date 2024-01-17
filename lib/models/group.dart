import 'package:http/http.dart';

class Group {
  int id;
  String name_en_us;
  String? name_ru_ru;
  String? name_uz_crl;
  String? name_uz_uz;
  int? number;
  String? image;
  Group({
    required this.id,
    required this.name_en_us,
    this.name_ru_ru,
    this.name_uz_crl,
    this.name_uz_uz,
    this.number,
    this.image,
  });
  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name_en_us: json["name_en_us"],
        name_ru_ru: json["name_ru_ru"],
        name_uz_crl: json["name_uz_crl"],
        name_uz_uz: json["name_uz_uz"],
        number: json["number"],
        image: json["image"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name_en_us,
        "name_ru_ru": name_ru_ru,
        "name_uz_crl": name_uz_crl,
        "name_uz_uz": name_uz_uz,
        "number": number,
        "image": image,
      };
}
