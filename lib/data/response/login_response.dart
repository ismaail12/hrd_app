// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
    String message;
    Data data;

    LoginResponse({
        required this.message,
        required this.data,
    });

    LoginResponse copyWith({
        String? message,
        Data? data,
    }) => 
        LoginResponse(
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    User user;
    String token;

    Data({
        required this.user,
        required this.token,
    });

    Data copyWith({
        User? user,
        String? token,
    }) => 
        Data(
            user: user ?? this.user,
            token: token ?? this.token,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    int id;
    String name;
    String email;
    dynamic emailVerifiedAt;
    String jabatan;
    String username;
    String kontak;
    String alamat;
    String role;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.email,
        this.emailVerifiedAt,
        required this.jabatan,
        required this.username,
        required this.kontak,
        required this.alamat,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
    });

    User copyWith({
        int? id,
        String? name,
        String? email,
        dynamic emailVerifiedAt,
        String? jabatan,
        String? username,
        String? kontak,
        String? alamat,
        String? role,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        User(
            id: id ?? this.id,
            name: name ?? this.name,
            email: email ?? this.email,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            jabatan: jabatan ?? this.jabatan,
            username: username ?? this.username,
            kontak: kontak ?? this.kontak,
            alamat: alamat ?? this.alamat,
            role: role ?? this.role,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        jabatan: json["jabatan"],
        username: json["username"],
        kontak: json["kontak"],
        alamat: json["alamat"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "jabatan": jabatan,
        "username": username,
        "kontak": kontak,
        "alamat": alamat,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
