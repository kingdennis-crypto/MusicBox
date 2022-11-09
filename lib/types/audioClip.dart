import 'package:musicbox/types/category.dart';

class AudioClip {
  int id;
  int? seasonNumber;
  int? episodeNumber;
  String title;
  String description;
  String? formattedDescription;
  String updatedAt;
  DateTime uploadedAt;
  Duration duration;
  String detail;

  AudioClip.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['id'],
        seasonNumber = json['season_number'] ?? json['season_number'],
        episodeNumber = json['episode_number'] ?? json['episode_number'],
        title = json['title'],
        description = json['description'] ?? json['description'],
        formattedDescription =
            json['formatted_description'] ?? json['formatted_description'],
        updatedAt = json['updated_at'],
        uploadedAt = DateTime.parse(json['uploaded_at'].toString()),
        duration = Duration(
            seconds: double.parse(json['duration'].toString()).toInt()),
        detail = json['urls']['detail'];

  String getDurationString() {
    String twoDigits(int n) => n.toString().padLeft(1, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));

    if (duration.inHours >= 1) {
      if (duration.inHours == 1) {
        if (duration.inMinutes.remainder(60) == 1) {
          return "${twoDigits(duration.inHours)} hour $twoDigitMinutes min";
        }

        return "${twoDigits(duration.inHours)} hour $twoDigitMinutes mins";
      }
    }

    return "$twoDigitMinutes mins";
  }

  @override
  String toString() {
    return "$title with id: $id";
  }
}
