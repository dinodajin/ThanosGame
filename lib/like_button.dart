import 'package:flutter/material.dart';

// 좋아요 및 싫어요 버튼을 만들기 위해 StatefulWidget을 상속 받습니다.
class LikeDislikeButton extends StatefulWidget {
  LikeDislikeButton({super.key});

  @override
  LikeDislikeButtonState createState() => LikeDislikeButtonState();
}

// 좋아요 및 싫어요 상태를 관리하기 위해 State를 상속 받습니다.
class LikeDislikeButtonState extends State<LikeDislikeButton> {
  // 좋아요와 싫어요 상태를 나타내는 변수입니다.
  bool _isLiked = false;
  bool _isDisliked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // 버튼들을 가운데에 정렬합니다.
        children: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: _isLiked ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
                // 좋아요를 눌렀을 때, 싫어요가 활성화되어 있으면 비활성화합니다.
                if (_isLiked) _isDisliked = false;
              });
            },
          ),
          IconButton(
            icon: Icon(
              _isDisliked ? Icons.thumb_down : Icons.thumb_down_alt_outlined, // 상태에 따라 아이콘을 변경합니다.
              color: _isDisliked ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isDisliked = !_isDisliked;
                // 싫어요를 눌렀을 때, 좋아요가 활성화되어 있으면 비활성화합니다.
                if (_isDisliked) _isLiked = false;
              });
            },
          ),
        ],
      ),
    );
  }
}