import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mapexample/utils/services.dart';
import 'package:mapexample/video_player_screen.dart';

import 'model/channelInfo.dart';
import 'model/viideos_list.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  ChannelInfo _channelInfo;
  VideosList _videosList;
  Item _item;
  bool _loading;
  String _playListId;
  String _nextPageToken;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos = List();
    _getChannelInfo();
  }

  _getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items[0];
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    print('_playListId $_playListId');
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    _nextPageToken = tempVideosList.nextPageToken;
    _videosList.videos.addAll(tempVideosList.videos);
    print('videos: ${_videosList.videos.length}');
    print('_nextPageToken $_nextPageToken');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'YouTube'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification) {
                  if (_videosList.videos.length >=
                      int.parse(_item.statistics.videoCount)) {
                    return true;
                  }
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    _loadVideos();
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _videosList.videos.length,
                  itemBuilder: (context, index) {
                    VideoItem videoItem = _videosList.videos[index];
                    return InkWell(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return VideoPlayerScreen(
                                // videoItem: videoItem,
                              );
                            }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: videoItem
                                  .video.thumbnails.thumbnailsDefault.url,
                            ),
                            SizedBox(width: 20),
                            Flexible(child: Text(videoItem.video.title)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInfoView() {
    return _loading
        ? CircularProgressIndicator()
        : Container(
      padding: EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  _item.snippet.thumbnails.medium.url,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  _item.snippet.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(_item.statistics.videoCount),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}




















//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   //
//    ChannelInfo _channelInfo;
//   // VideosList _videosList;
//    Item _item;
//    bool _loading;
//    String _playListId;
//    String _nextPageToken;
//    ScrollController _scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     _loading = true;
//     _nextPageToken = '';
//     _scrollController = ScrollController();
//     // _videosList = VideosList();
//     // _videosList.videos = List();
//     _getChannelInfo();
//   }
//
//   _getChannelInfo() async {
//     _channelInfo = await Services.getChannelInfo();
//     _item = _channelInfo.items[0];
//     _playListId = _item.contentDetails.relatedPlaylists.uploads;
//     print('_playListId $_playListId');
//     // await _loadVideos();
//     setState(() {
//       _loading = false;
//     });
//   }
//
//   //
//   // _loadVideos() async {
//   //   VideosList tempVideosList = await Services.getVideosList(
//   //     playListId: _playListId,
//   //     pageToken: _nextPageToken,
//   //   );
//   //   _nextPageToken = tempVideosList.nextPageToken;
//   //   _videosList.videos.addAll(tempVideosList.videos);
//   //   print('videos: ${_videosList.videos.length}');
//   //   print('_nextPageToken $_nextPageToken');
//   //   setState(() {});
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_loading ? 'Loading...' : 'YouTube'),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             _buildInfoView(),
//
//
//         Container(
//           margin: EdgeInsets.all(20.0),
//           padding: EdgeInsets.all(20.0),
//           height: 100.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 offset: Offset(0, 1),
//                 blurRadius: 6.0,
//               ),
//             ],
//           ),
//           // child: Row(
//           //   children: <Widget>[
//           //     CircleAvatar(
//           //       backgroundColor: Colors.white,
//           //       radius: 35.0,
//           //       backgroundImage: NetworkImage(_item.snippet.thumbnails.medium.url),
//           //     ),              SizedBox(width: 12.0),
//           //     Expanded(
//           //       child: Column(
//           //         mainAxisAlignment: MainAxisAlignment.center,
//           //         crossAxisAlignment: CrossAxisAlignment.start,
//           //         children: <Widget>[
//           //           Text(
//           //             _item.snippet.title,
//           //             style: TextStyle(
//           //               color: Colors.black,
//           //               fontSize: 20.0,
//           //               fontWeight: FontWeight.w600,
//           //             ),
//           //             overflow: TextOverflow.ellipsis,
//           //           ),
//           //           Text(
//           //             '${_item.statistics.subscriberCount} subscribers',
//           //             style: TextStyle(
//           //               color: Colors.grey[600],
//           //               fontSize: 16.0,
//           //               fontWeight: FontWeight.w600,
//           //             ),
//           //             overflow: TextOverflow.ellipsis,
//           //           ),
//           //         ],
//           //       ),
//           //     )
//           //   ],
//           // ),
//         ),
//
//             // Expanded(
//             //   child: NotificationListener<ScrollEndNotification>(
//             //     onNotification: (ScrollNotification notification) {
//             //       if (_videosList.videos.length >=
//             //           int.parse(_item.statistics.videoCount)) {
//             //         return true;
//             //       }
//             //       if (notification.metrics.pixels ==
//             //           notification.metrics.maxScrollExtent) {
//             //         _loadVideos();
//             //       }
//             //       return true;
//             //     },
//             //     child: ListView.builder(
//             //       controller: _scrollController,
//             //       itemCount: _videosList.videos.length,
//             //       itemBuilder: (context, index) {
//             //         VideoItem videoItem = _videosList.videos[index];
//             //         return InkWell(
//             //           onTap: () async {
//             //             Navigator.push(context,
//             //                 MaterialPageRoute(builder: (context) {
//             //                   return VideoPlayerScreen(
//             //                     videoItem: videoItem,
//             //                   );
//             //                 }));
//             //           },
//             //           child: Container(
//             //             padding: EdgeInsets.all(20.0),
//             //             child: Row(
//             //               children: [
//             //                 CachedNetworkImage(
//             //                   imageUrl: videoItem
//             //                       .video.thumbnails.thumbnailsDefault.url,
//             //                 ),
//             //                 SizedBox(width: 20),
//             //                 Flexible(child: Text(videoItem.video.title)),
//             //               ],
//             //             ),
//             //           ),
//             //         );
//             //       },
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _buildInfoView() {
//     return _loading
//         ? CircularProgressIndicator()
//         : Container(
//       padding: EdgeInsets.all(20.0),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(
//                   _item.snippet.thumbnails.medium.url,
//                 ),
//               ),
//               SizedBox(width: 20),
//               Expanded(
//                 child: Text(
//                   _item.snippet.title,
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               Text(_item.statistics.videoCount),
//               SizedBox(width: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
