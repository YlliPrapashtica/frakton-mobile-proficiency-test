import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/catchUsers.dart';
import 'package:flutter_application/main.dart';
import 'package:photo_view/photo_view.dart';

//Single User Data
class UserData {
  UserData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

//Pull Data From Nested JSON Data
  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}

class SingleUser extends StatefulWidget {
  final UserData singleUser;

  SingleUser({Key? key, required this.singleUser}) : super(key: key);

  @override
  _SingleUserState createState() => _SingleUserState();
}

//User Detail View
class _SingleUserState extends State<SingleUser> {
  @override
  Widget build(BuildContext context) {
    //Catch Index Of Selected User From The HomePage
    final indexObject = ModalRoute.of(context)!.settings.arguments;
    //Catch Future Users
    CatchUsers argument = indexObject as CatchUsers;

    var userIndex = argument.userIndex;
    var data = argument.data;
    //Create Increments for Next/Previous User
    int nextUserIncrement;
    int prevUserIncrement;

    //Check If the User Opened is First/Last
    if (userIndex == 0) {
      nextUserIncrement = 1;
      prevUserIncrement = -11;
    } else if (userIndex > 0 && userIndex < 11) {
      nextUserIncrement = 1;
      prevUserIncrement = 1;
    } else if (userIndex == 11) {
      nextUserIncrement = -11;
      prevUserIncrement = 1;
    } else {
      nextUserIncrement = 0;
      prevUserIncrement = 0;
    }
    //Create Next User
    UserData nextUser = new UserData(
        id: data.data[userIndex + nextUserIncrement].id,
        email: data.data[userIndex + nextUserIncrement].email,
        firstName: data.data[userIndex + nextUserIncrement].firstName,
        lastName: data.data[userIndex + nextUserIncrement].lastName,
        avatar: data.data[userIndex + nextUserIncrement].avatar);

    //Create Previous User
    UserData prevUser = new UserData(
        id: data.data[userIndex - prevUserIncrement].id,
        email: data.data[userIndex - prevUserIncrement].email,
        firstName: data.data[userIndex - prevUserIncrement].firstName,
        lastName: data.data[userIndex - prevUserIncrement].lastName,
        avatar: data.data[userIndex - prevUserIncrement].avatar);
//Print User Details View
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //Set User Name + Last Name As The Title Of The Page
          widget.singleUser.firstName + " " + widget.singleUser.lastName,
        ),
        //If Pressed Back Arrow, Send To The HomePage
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          child: Icon(Icons.arrow_back_ios_rounded), // add custom icons also
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: Column(
              //Full Data Container
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Container(
                    //Inner Container Using 72% Of Screen Height
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF6F6F6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF6F6F6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      //User ID
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "User ID: " + widget.singleUser.id.toString(),
                                  style: TextStyle(
                                    color: Color(0xFF7E7E7E),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'CharlevoixPro',
                                    letterSpacing: 0.5,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //User Avatar
                          Container(
                            height: 220,
                            width: 220,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRect(
                                child: PhotoView(
                                  backgroundDecoration:
                                      BoxDecoration(color: Colors.transparent),
                                  imageProvider:
                                      NetworkImage(widget.singleUser.avatar),
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.covered * 2,
                                ),
                              ),
                            ),
                          ),
                          //User First Name Label
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text("First Name: ",
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'CharlevoixPro',
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          //User First Name
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(widget.singleUser.firstName,
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'CharlevoixPro',
                                  letterSpacing: 0.5,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          //User First Name Underline
                          Divider(
                            height: 2,
                            thickness: 2,
                            indent: 70,
                            endIndent: 70,
                            color: Colors.white,
                          ),
                          //User Last Name Label
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text("Last Name: ",
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'CharlevoixPro',
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          //User Last Name
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(widget.singleUser.lastName,
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'CharlevoixPro',
                                  letterSpacing: 0.5,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          //User Last Name Underline
                          Divider(
                            height: 2,
                            thickness: 2,
                            indent: 70,
                            endIndent: 70,
                            color: Colors.white,
                          ),
                          //User Email Label
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                            child: Text("Email: ",
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'CharlevoixPro',
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          //User Email
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(widget.singleUser.email,
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'CharlevoixPro',
                                  letterSpacing: 0.5,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Button Container
                Expanded(
                  child: Align(
                    alignment: Alignment(0.35, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //Left Button
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => //Open Previous User Data
                                    SingleUser(singleUser: prevUser),
                                settings: RouteSettings(
                                  arguments: CatchUsers(
                                      userIndex - prevUserIncrement, data),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded),
                          color: Color(0XFFFFD300),
                          iconSize: 30,
                        ),
                        //Right Button
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => //Open Necxt User Data
                                    SingleUser(singleUser: nextUser),
                                settings: RouteSettings(
                                  arguments: CatchUsers(
                                      userIndex + nextUserIncrement, data),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          color: Color(0XFFFFD300),
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
