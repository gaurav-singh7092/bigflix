import 'package:bigflix/widgets/responsive.dart';
import 'package:bigflix/widgets/vertical_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:bigflix/models/models.dart';
import 'package:video_player/video_player.dart';
class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({super.key, required this.featuredContent});
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _ContentHeaderMobile(featuredContent: featuredContent),
        desktop: _ContentHeaderDesktop(featuredContent : featuredContent),
    );
  }
}
class _ContentHeaderMobile extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({super.key, required this.featuredContent});

  @override
  State<_ContentHeaderMobile> createState() => _ContentHeaderMobileState();
}

class _ContentHeaderMobileState extends State<_ContentHeaderMobile> {
  late VideoPlayerController _videoController;
  bool isMuted = true;
  @override
  void initState() {

    super.initState();
    _videoController = VideoPlayerController.network(widget.featuredContent.videoUrl.toString())
      ..initialize().then((_) => setState(() {}))..play()..setVolume(0);

  }
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final Size size = _videoController.value.size;
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying ? _videoController.pause() : _videoController.play(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.isInitialized ? 0.9 : 0.8,
            child: _videoController.value.isInitialized ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: Container(
                    width: size.width,
                    height: size.height,
                    child: VideoPlayer(_videoController)),
              ),
            ) :
            Image.asset(widget.featuredContent.imageUrl.toString(), fit: BoxFit.cover,),
          ),
          AspectRatio(
            aspectRatio: _videoController.value.isInitialized ? 0.9 : 0.8,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
              left: 285.0,
              right: 0.0,
              bottom: 90.0,
              child: Row(
            children: [
              if (_videoController.value.isInitialized)
                IconButton(icon: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up),
                  color: Colors.white,
                  iconSize: 30.0,
                  onPressed: () => setState(() {
                    isMuted ? _videoController.setVolume(100) : _videoController.setVolume(0);
                    isMuted = _videoController.value.volume == 0;
                  }),
                ),
            ],
          )
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: 'Add',
                  onTap: () => print('My List'),
                ),
                _PlayButton(),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: 'Info',
                  onTap: () => print('Info'),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({super.key, required this.featuredContent});

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoController;
  bool isMuted = true;
  @override
  void initState() {

    super.initState();
    _videoController = VideoPlayerController.network(widget.featuredContent.videoUrl.toString())
      ..initialize().then((_) => setState(() {}))..play()..setVolume(0);

  }
  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoController.value.isPlaying ? _videoController.pause() : _videoController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
              aspectRatio: _videoController.value.isInitialized ? _videoController.value.aspectRatio : 2.344,
            child: _videoController.value.isInitialized ? VideoPlayer(_videoController) : Image.asset(widget.featuredContent.imageUrl.toString(), fit: BoxFit.cover,),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -1.0,
            child: AspectRatio(
              aspectRatio: _videoController.value.isInitialized ? _videoController.value.aspectRatio : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.featuredContent.description.toString(),
                  style: const TextStyle(
                    color:  Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(2.0, 4.0), blurRadius: 6.0)
                    ]
                  ),
                ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                _PlayButton(),
                const SizedBox(width: 16.0,),
                TextButton.icon(
                  onPressed: () => print('More Info'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                    backgroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.info_outline, color: Colors.black, size: 30.0,),
                  label: const Text(
                    'More Info',
                    style: TextStyle(color: Colors.black,fontSize: 16.0, fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                const SizedBox(width: 20.0,),
                if (_videoController.value.isInitialized)
                  IconButton(icon: Icon(
                      isMuted ? Icons.volume_off : Icons.volume_up),
                    color: Colors.white,
                    iconSize: 30.0,
                    onPressed: () => setState(() {
                      isMuted ? _videoController.setVolume(100) : _videoController.setVolume(0);
                      isMuted = _videoController.value.volume == 0;
                    }),
                  ),
              ],
            ),
            ]
          ),

          )
        ],
      ),
    );
  }
}
class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => print('Play'),
      style: TextButton.styleFrom(
        padding: !Responsive.isDesktop(context) ?
        const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0) :
        const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
        backgroundColor: Colors.white,
      ),
      icon: const Icon(Icons.play_arrow, size: 30.0,color: Colors.black,),
      label: const Text(
        'Play',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
