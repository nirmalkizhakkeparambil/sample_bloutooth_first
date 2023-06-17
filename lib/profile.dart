import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Map<String, dynamic> profileData = {};
  //   "results": [
  //     {
  //       "gender": "female",
  //       "name": {"title": "Ms", "first": "درسا", "last": "صدر"},
  //       "location": {
  //         "street": {"number": 8309, "name": "شهید کشواد"},
  //         "city": "نیشابور",
  //         "state": "خراسان شمالی",
  //         "country": "Iran",
  //         "postcode": 95289,
  //         "coordinates": {"latitude": "14.9395", "longitude": "121.7953"},
  //         "timezone": {"offset": "-9:00", "description": "Alaska"}
  //       },
  //       "email": "drs.sdr@example.com",
  //       "login": {
  //         "uuid": "56c1d8c5-fab9-49c1-8c98-aea52066b985",
  //         "username": "lazymouse939",
  //         "password": "microsof",
  //         "salt": "PRKLVgYX",
  //         "md5": "fd1a794e1b3b9c2fe7891963ff9ebb04",
  //         "sha1": "7cd455c7dc40ea0a9fb84fb5b0402e51e9087bc7",
  //         "sha256":
  //             "fa17341cf3bcef81ce3214393780a2b302e7d82c156e51efd28c09e94f76666d"
  //       },
  //       "dob": {"date": "1983-06-01T06:27:39.552Z", "age": 40},
  //       "registered": {"date": "2009-06-16T22:08:14.405Z", "age": 14},
  //       "phone": "003-47553798",
  //       "cell": "0914-002-9043",
  //       "id": {"name": "", "value": null},
  //       "picture": {
  //         "large": "https://randomuser.me/api/portraits/women/14.jpg",
  //         "medium": "https://randomuser.me/api/portraits/med/women/14.jpg",
  //         "thumbnail": "https://randomuser.me/api/portraits/thumb/women/14.jpg"
  //       },
  //       "nat": "IR"
  //     }
  //   ],
  //   "info": {
  //     "seed": "2bbc3dc459131fbf",
  //     "results": 1,
  //     "page": 1,
  //     "version": "1.4"
  //   }
  // };

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      var data = await fetchProfileData();
      setState(() {
        profileData = data;
      });
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchProfileData() async {
    var apiUrl =
        'https://randomuser.me/api/'; // Replace 'API_URL_HERE' with the actual API URL

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      var results = decodedJson['results'];
      var profileData = results[0];
      return profileData;
    } else {
      throw Exception('Failed to fetch profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: profileData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(profileData['picture']['large']),
                  SizedBox(height: 16),
                  Text(
                      'Name: ${profileData['name']['first']} ${profileData['name']['last']}'),
                  Text('Gender: ${profileData['gender']}'),
                  Text('Email: ${profileData['email']}'),
                  // Display other profile details as needed
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
