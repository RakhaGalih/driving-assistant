import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sdla/constants/constant.dart';

const String apiURL = "https://backend-smartcar.rakis.my.id";
String token = "";

Future<void> fetchData(String address) async {
  final response = await http.get(Uri.parse(apiURL + address));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String, dynamic>> getUserDetails() async {
  final uri = Uri.parse("$apiURL/api/admin/user");
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Failed to load user details. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load user details');
  }
}

Future<Map<String, dynamic>> getUserTrip() async {
  final uri = Uri.parse("$apiURL/api/admin/trips");
  final response = await http.get(
    uri,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Failed to load user details. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load user details');
  }
}

Future<Map<String, dynamic>> postData(
    String address, Map<String, dynamic> body) async {
  final uri = Uri.parse(apiURL + address);
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    print('Failed to post data. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return jsonDecode(response.body);
  }
}

Future<Map<String, dynamic>> startTrip() async {
  final uri = Uri.parse("$apiURL/api/admin/trips/start");
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    print('Failed to start trip. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to start trip');
  }
}

Future<Map<String, dynamic>> stopTrip() async {
  final uri = Uri.parse("$apiURL/api/admin/trips/stop");
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    print('Failed to start trip. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to stop trip');
  }
}

Future<Map<String, dynamic>> logout() async {
  final uri = Uri.parse("$apiURL/api/admin/logout");
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    print('Failed to logout. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to logout');
  }
}

// Fungsi untuk mengunduh file dari URL
Future<File> downloadFile(String url, String filename) async {
  var response = await http.get(Uri.parse(url));

  var dir = await getTemporaryDirectory();

  var file = File(path.join(dir.path, filename));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

// Fungsi untuk memperbarui data pengguna
Future<Map<String, dynamic>> updateDataUser(String name, String email,
    {File? imageFile}) async {
  int id = 0;
  try {
    var response = await getUserDetails();
    id = response['id'];
  } catch (e) {
    print('Fetch data error: $e');
    return {};
  }

  var uri = Uri.parse("$apiURL/api/admin/users/$id");

  var request = http.MultipartRequest('POST', uri);

  request.headers['Accept'] = 'application/json';
  request.headers['Authorization'] = 'Bearer $token';

  request.fields['name'] = name;
  request.fields['email'] = email;
  request.fields['_method'] = 'PATCH';

  // Jika tidak ada file gambar yang diberikan, unduh gambar dari URL
  if (imageFile == null) {
    try {
      var userDetails = await getUserDetails();
      String imageUrl = userDetails['image'];
      imageFile = await downloadFile(imageUrl, 'default_image.jpg');
    } catch (e) {
      print('Error downloading file: $e');
      return {};
    }
  }

  var mimeTypeData = lookupMimeType(imageFile.path)?.split('/');

  var fileStream = http.ByteStream(imageFile.openRead());
  var fileLength = await imageFile.length();
  var multipartFile = http.MultipartFile(
    'image',
    fileStream,
    fileLength,
    filename: path.basename(imageFile.path),
    contentType: mimeTypeData != null
        ? MediaType(mimeTypeData[0], mimeTypeData[1])
        : null,
  );

  request.files.add(multipartFile);

  Map<String, dynamic> responseBody = {};
  try {
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Upload successful');
    } else {
      print('Upload failed with status: ${response.statusCode}');
    }

    responseBody = jsonDecode(await response.stream.bytesToString());
    print('Response body: $responseBody');
    return responseBody;
  } catch (e) {
    print('Upload error: $e');
    return responseBody;
  }
}

class MyNetworkImage extends StatelessWidget {
  final String imageURL;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const MyNetworkImage({
    super.key,
    required this.imageURL,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(imageURL, width: width, height: height, fit: fit,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: kBlue,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          ),
        );
      }
    }, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      return SizedBox(
          width: width,
          height: height,
          child: const Center(
              child: Text(
            'Failed to load image',
            textAlign: TextAlign.center,
          )));
    });
  }
}
