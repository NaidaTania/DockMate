/*
The chat main screen

The main entry points:
1. A plus button maybe at top of page (to create new message)
  then open an empty chat form
    validate on clicking send
2. From clicking a link somewhere
  if from clicking a link somewhere, just need to digest data

*/

import 'package:flutter/material.dart';
import './message.dart';
import '../model/chat.dart';
import '../utils/sampleData.dart';
import '../utils/bottombar.dart';

class Chatroom extends StatefulWidget {
  String title;
  Chatroom({this.title});
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  Stream chatStream;

  Widget decideChatInterface(snapshot) {
    if (snapshot.data == null) {
      return Container(child: Text("There is no chat here yet"));
    }
    return ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          return ChatRoomsTile();
        });
  }

  Widget chatStreamBuilder() {
    return StreamBuilder(
      stream: chatStream,
      builder: (context, snapshot) => decideChatInterface(snapshot),
    );
  }

  _createNewChatroom() {
    //Will ideally check against existing users and all that
    //but for now will just create a blank chatroom
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MessageRoom()),
    );
  }

  Widget _fillChatroom() {
    //sample
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 15),
        child: Column(children: <Widget>[
          ChatroomTile(sampleChatTile),
          ChatroomTile(sampleChatTile),
          ChatroomTile(sampleChatTile),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: _fillChatroom(),
      ),
      bottomNavigationBar: BottomBar(bottomIndex: 2),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewChatroom(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Listings'),
  //       actions: <Widget>[
  //         IconButton(
  //           icon: Icon(Icons.add),
  //           onPressed: createNewChatroom(),
  //         )
  //       ],
  //     ),
  //     body: Center(child: Text("Just checking that it works")),
  //     // child: chatStreamBuilder(), //populate if some chat data already exist
  //     // ),
  //     bottomNavigationBar: BottomBar(bottomIndex: 0),
  //   );
  // }
}

class ChatroomTile extends StatelessWidget {
  Chat chatroomData;

  ChatroomTile(this.chatroomData);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(chatroomData.imageURL,
                      width: 100, height: 100)),
              Container(
                  padding: EdgeInsets.only(top: 12),
                  margin: EdgeInsets.only(right: 60),
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: Text(
                              chatroomData.users[1].first_name +
                                  chatroomData.users[1].last_name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold))),
                      Text(chatroomData.lastMessage),
                    ],
                  ))
            ],
          ),
        ),
        onTap: () {
          //open a message for now
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MessageRoom()),
          );
          //and then fill up with existing messages
          //can animate it in future: https://flutter.dev/docs/cookbook/animation/page-route-animation
        });
  }
}
