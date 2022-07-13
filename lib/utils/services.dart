import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/channelInfo.dart';
import '../model/viideos_list.dart';
import 'constants.dart';
//
// class Services {
//   //
//   static const CHANNEL_ID = 'UCBKM1j5cedbCoRzEAk-SQfg';
//   static const _baseUrl = 'https://youtube.googleapis.com';
//
// /*
//
//   curl \
//   'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UCBKM1j5cedbCoRzEAk-SQfg&access_token=AIzaSyAVHCtGMdN9MC9eYPJUzZxj6TJLE1oVvBI&key=[YOUR_API_KEY]' \
//   --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
//   --header 'Accept: application/json' \
//   --compressed
// */
//
//
//
//
//
//   static Future<ChannelInfo> getChannelInfo() async {
//     Map<String, String> parameters = {
//       'part': 'snippet,contentDetails,statistics',
//       'id': CHANNEL_ID,
//       'key': Constants.API_KEY,
//     };
//     Map<String, String> headers = {
//       HttpHeaders.contentTypeHeader: 'application/json',
//     };
//     Uri uri = Uri.https(
//       _baseUrl,
//       '/youtube/v3/channels',
//       parameters,
//     );
//     Response response = await http.get(uri, headers: headers);
//     // print(response.body);
//     ChannelInfo channelInfo = channelInfoFromJson(response.body);
//     return channelInfo;
//   }
//
//
//
//
//   // static Future<VideosList> getVideosList(
//   //     {String playListId, String pageToken}) async {
//   //   Map<String, String> parameters = {
//   //     'part': 'snippet',
//   //     'playlistId': playListId,
//   //     'maxResults': '8',
//   //     'pageToken': pageToken,
//   //     'key': Constants.API_KEY,
//   //   };
//   //   Map<String, String> headers = {
//   //     HttpHeaders.contentTypeHeader: 'application/json',
//   //   };
//   //   Uri uri = Uri.https(
//   //     _baseUrl,
//   //     '/youtube/v3/playlistItems',
//   //     parameters,
//   //   );
//   //   Response response = await http.get(uri, headers: headers);
//   //   // print(response.body);
//   //   VideosList videosList = videosListFromJson(response.body);
//   //   return videosList;
//   // }
// }



// /*
//
//   curl \
//   'https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UCBKM1j5cedbCoRzEAk-SQfg&access_token=AIzaSyAVHCtGMdN9MC9eYPJUzZxj6TJLE1oVvBI&key=[YOUR_API_KEY]' \
//   --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
//   --header 'Accept: application/json' \
//   --compressed
// */
//





class Services {
  //
  static const CHANNEL_ID = 'UCBKM1j5cedbCoRzEAk-SQfg';
  static const _baseUrl = 'youtube.googleapis.com';

  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

  static Future<VideosList> getVideosList(
      {String playListId, String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
