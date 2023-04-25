// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

class Eczane {
  final String EczaneAdi;
  final String Adresi;
  final String Semt;
  final String YolTarifi;
  final String Telefon;
  final String Telefon2;
  final String sehir;
  final String ilce;
  final double latitude;
  final double longitude;
  Eczane({
    required this.EczaneAdi,
    required this.Adresi,
    required this.Semt,
    required this.YolTarifi,
    required this.Telefon,
    required this.Telefon2,
    required this.sehir,
    required this.ilce,
    required this.latitude,
    required this.longitude,
  });

  Eczane copyWith({
    String? EczaneAdi,
    String? Adresi,
    String? Semt,
    String? YolTarifi,
    String? Telefon,
    String? Telefon2,
    String? sehir,
    String? ilce,
    double? latitude,
    double? longitude,
  }) {
    return Eczane(
      EczaneAdi: EczaneAdi ?? this.EczaneAdi,
      Adresi: Adresi ?? this.Adresi,
      Semt: Semt ?? this.Semt,
      YolTarifi: YolTarifi ?? this.YolTarifi,
      Telefon: Telefon ?? this.Telefon,
      Telefon2: Telefon2 ?? this.Telefon2,
      sehir: sehir ?? this.sehir,
      ilce: ilce ?? this.ilce,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'EczaneAdi': EczaneAdi,
      'Adresi': Adresi,
      'Semt': Semt,
      'YolTarifi': YolTarifi,
      'Telefon': Telefon,
      'Telefon2': Telefon2,
      'sehir': sehir,
      'ilce': ilce,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Eczane.fromMap(Map<String, dynamic> map) {
    return Eczane(
      EczaneAdi: map['EczaneAdi'] as String,
      Adresi: map['Adresi'] as String,
      Semt: map['Semt'] == null ? "" : map['Semt'] as String,
      YolTarifi: map['YolTarifi'] == null ? "" : map["YolTarifi"],
      Telefon: map['Telefon'] as String,
      Telefon2: map['Telefon2'] == null ? "" : map["Telefon'"],
      sehir: map['Sehir'] as String,
      ilce: map['ilce'] as String,
      latitude: map['latitude']?.toDouble() ?? 0,
      longitude: map['longitude']?.toDouble() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Eczane.fromJson(String source) =>
      Eczane.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Eczane(EczaneAdi: $EczaneAdi, Adresi: $Adresi, Semt: $Semt, YolTarifi: $YolTarifi, Telefon: $Telefon, Telefon2: $Telefon2, sehir: $sehir, ilce: $ilce, latitude: $latitude, longitude: $longitude)';
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  bool operator ==(covariant Eczane other) {
    if (identical(this, other)) return true;

    return other.EczaneAdi == EczaneAdi &&
        other.Adresi == Adresi &&
        other.Semt == Semt &&
        other.YolTarifi == YolTarifi &&
        other.Telefon == Telefon &&
        other.Telefon2 == Telefon2 &&
        other.sehir == sehir &&
        other.ilce == ilce &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return EczaneAdi.hashCode ^
        Adresi.hashCode ^
        Semt.hashCode ^
        YolTarifi.hashCode ^
        Telefon.hashCode ^
        Telefon2.hashCode ^
        sehir.hashCode ^
        ilce.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
