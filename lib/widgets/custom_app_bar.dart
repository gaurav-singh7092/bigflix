import 'package:bigflix/widgets/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({super.key,this.scrollOffset = 0.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      color: Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: Responsive(
        mobile: _CustomAppBarMobile(),
        desktop: _CustomAppBarDesktop(),
      )
    );
  }
}
class _CustomAppBarMobile extends StatelessWidget {
  const _CustomAppBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(width: 12.0,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: 'TV Shows', onTap: () => print('TV Shows')),
                _AppBarButton(title: 'Movies', onTap: () => print('Movies')),
                _AppBarButton(title: 'My List', onTap: () => print('My List')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  const _CustomAppBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(width: 12.0,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: 'Home', onTap: () => print('My List')),
                _AppBarButton(title: 'TV Shows', onTap: () => print('TV Shows')),
                _AppBarButton(title: 'Movies', onTap: () => print('Movies')),
                _AppBarButton(title: 'Latest', onTap: () => print('My List')),
                _AppBarButton(title: 'My List', onTap: () => print('My List')),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                icon: Icon(Icons.search),
                padding: EdgeInsets.zero,
                iconSize: 28.0,
                color: Colors.white,
                onPressed: () => print('Search'),
                ),
                _AppBarButton(title: 'DVD', onTap: () => print('DVD')),
                _AppBarButton(title: 'Kids', onTap: () => print('Kids')),
                IconButton(
                  icon: Icon(Icons.card_giftcard),
                  padding: EdgeInsets.zero,
                  iconSize: 28.0,
                  color: Colors.white,
                  onPressed: () => print('Gift'),
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  padding: EdgeInsets.zero,
                  iconSize: 28.0,
                  color: Colors.white,
                  onPressed: () => print('notifications'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const _AppBarButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
          child: Text(title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
  }
}
