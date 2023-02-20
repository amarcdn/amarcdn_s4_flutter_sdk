import 'dart:convert';

class RegionModel {
  String regionUrl;
  String regionKey;
  String regionId;
  String regionTitle;
  RegionModel({
    required this.regionUrl,
    required this.regionKey,
    required this.regionId,
    required this.regionTitle,
  });

  RegionModel copyWith({
    String? regionUrl,
    String? regionKey,
    String? regionId,
    String? regionTitle,
  }) {
    return RegionModel(
      regionUrl: regionUrl ?? this.regionUrl,
      regionKey: regionKey ?? this.regionKey,
      regionId: regionId ?? this.regionId,
      regionTitle: regionTitle ?? this.regionTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'regionUrl': regionUrl,
      'regionKey': regionKey,
      'regionId': regionId,
      'regionTitle': regionTitle,
    };
  }

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      regionUrl: map['regionUrl'] as String,
      regionKey: map['regionKey'] as String,
      regionId: map['regionId'] as String,
      regionTitle: map['regionTitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionModel.fromJson(String source) =>
      RegionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegionModel(regionUrl: $regionUrl, regionKey: $regionKey, regionId: $regionId, regionTitle: $regionTitle)';
  }

  @override
  bool operator ==(covariant RegionModel other) {
    if (identical(this, other)) return true;

    return other.regionUrl == regionUrl &&
        other.regionKey == regionKey &&
        other.regionId == regionId &&
        other.regionTitle == regionTitle;
  }

  @override
  int get hashCode {
    return regionUrl.hashCode ^
        regionKey.hashCode ^
        regionId.hashCode ^
        regionTitle.hashCode;
  }
}
