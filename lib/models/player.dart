// ignore_for_file: public_member_api_docs, sort_constructors_first

class Player {
  final String nickname;
  final String socketId;
  final double points;
  final String playertype;
  Player({
    required this.nickname,
    required this.socketId,
    required this.points,
    required this.playertype,
  });

  Player copyWith({
    String? nickname,
    String? socketId,
    double? points,
    String? playertype,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playertype: playertype ?? this.playertype,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketId': socketId,
      'points': points,
      'playertype': playertype,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] as String,
      socketId: map['socketId'] as String,
      points: map['points'].toDouble(),
      playertype: map['playertype'] as String,
    );
  }
}
