import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_assignment/model/database_helper3.dart';
import 'package:path_provider/path_provider.dart';

class InsertVideo extends StatefulWidget {
  const InsertVideo({super.key});

  @override
  State<InsertVideo> createState() => _InsertVideoState();
}

class _InsertVideoState extends State<InsertVideo> {
  TextEditingController videoTitleController = TextEditingController();
  var videoController = VideoPlayerController.file(File("path"));

  File? _video;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        videoController = VideoPlayerController.file(_video??File("path"))..initialize();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Insert User Video",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: SizedBox(
                  //   width: 300,
                  //   height: 200,
                  //   child: VideoPlayer(videoController),
                  // ),
                  child: InkWell(
                    onTap: () {
                      _getVideo();
                    },
                    child: SizedBox(
                      width: 300,
                      height: 500,
                      child: VideoPlayer(videoController)),
                    ),
                    // child: Container(
                    //   height: 150,
                    //   width: 200,
                    //   decoration: BoxDecoration(
                    //     border: Border.all()
                    //   ),
                    //   child: _video != null
                    //       ?  VideoPlayer(VideoPlayerController.networkUrl(Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),videoPlayerOptions: VideoPlayerOptions()))
                    //       : Icon(Icons.videocam, size: 50,),
                    // ),
                  ),
                IconButton(onPressed: (){
                  if(videoController.value.isPlaying){
                    videoController.pause();
                  }else{
                    videoController.play();
                  }
                  setState(() {});
                }, icon: videoController.value.isPlaying?Icon(Icons.pause):Icon(Icons.play_arrow)),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: videoTitleController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.ondemand_video),
                      hintText: "Enter Video Title"),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  if (videoTitleController.text.isNotEmpty && _video != null) {
                    final appDirectory =
                        await getApplicationDocumentsDirectory();
                    final videoPath =
                        '${appDirectory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
                    await _video!.copy(videoPath);

                    await VideoDataBaseHelper.instance.insertVideoData({
                      VideoDataBaseHelper.videoTitle: videoTitleController.text,
                      VideoDataBaseHelper.localVideo: videoPath
                    });
                    Fluttertoast.showToast(msg: "Upload Successful");
                    Navigator.pop(context);
                  }
                },
                child: Text("Upload Video")),
          )
        ],
      ),
    );
  }
}
