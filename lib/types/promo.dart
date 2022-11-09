import 'package:musicbox/types/audioClip.dart';

class Promo {
  int id;
  String title;
  String titleUrl;
  String? subtitle;
  int position;
  String updatedAt;
  String image;
  AudioClip audioClip;

  Promo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        titleUrl = json['title_url'],
        subtitle = json['subtitle'] ?? json['subtitle'],
        position = json['position'],
        updatedAt = json['updated_at'],
        image = json['image']['original'],
        audioClip = AudioClip.fromJson(json['audio_clip']);

  @override
  String toString() {
    return "$title with id: $id";
  }
}
