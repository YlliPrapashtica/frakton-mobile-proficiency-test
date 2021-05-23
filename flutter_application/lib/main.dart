import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/catchUsers.dart';
import 'package:http/http.dart' as http;
import 'userData.dart';
import 'screens/singleUserData.dart';

Future<Users> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?per_page=12'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Users.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user data');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Color(0xFFFFD300)),
          fontFamily: 'CharlevoixPro',
          scaffoldBackgroundColor: const Color(0xFFF6F6F6)),
      home: MyHomePage(title: 'Frakton Mobile Test App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Users> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_white.png',
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: List.generate(12, (index) {
          return Center(
            child: FutureBuilder<Users>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleUser(
                                singleUser: snapshot.data!.data[index]),
                            settings: RouteSettings(
                              arguments: CatchUsers(index, snapshot.data!),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 200,
                        width: 200,
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Image.network(
                                  snapshot.data!.data[index].avatar,
                                  height: 75,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                snapshot.data!.data[index].firstName +
                                    " " +
                                    snapshot.data!.data[index].lastName,
                                style: TextStyle(
                                  color: Color(0xFF7E7E7E),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'CharlevoixPro',
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                      ));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          );
        }),
      ),
    );
  }
}
