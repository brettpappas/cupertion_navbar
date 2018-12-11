import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: HomeScreen(title: 'Flutter Demo Home Page'),
        );
    }
}

class HomeScreen extends StatelessWidget {
    HomeScreen({Key key, this.title}) : super(key: key);
    final String title;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            resizeToAvoidBottomPadding: false,
            drawer: SideMenu(),
            body: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                    items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(Icons.ac_unit),
                            title: Text('One'),
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.access_alarm),
                            title: Text('Two'),
                        ),
                    ],
                ),
                tabBuilder: (BuildContext context, int index) {
                    switch (index) {
                        case 0:
                            return CupertinoTabView(
                                builder: (BuildContext context) => MainScreen(title: 'One',),
                            );
                            break;
                        case 1:
                            return CupertinoTabView(
                                builder: (BuildContext context) => MainScreen(title: 'Two',),
                            );
                            break;
                        default:
                    }
                },
            ),
        );
    }
}

class MainScreen extends StatelessWidget {
    MainScreen({Key key, this.title}) : super(key: key);
    final String title;

    @override
    Widget build(BuildContext context) {
        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                transitionBetweenRoutes: true,
                padding: EdgeInsetsDirectional.only(end:2.0),
                middle: Text(title),
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                        Scaffold.of(context).openDrawer();
                    },
                ),
            ),
            child: Container(
                child: Center(
                    // child: Text(title)
                    child: FlatButton(
                        color: Colors.amber,
                        child: Text(title + ': Sub Screen'),
                        onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (BuildContext context) {
                                    return SubScreen();
                                },
                                fullscreenDialog: false
                            ));
                        },
                    ),
                ),
            ),
        );
    }
}

class SubScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                transitionBetweenRoutes: true,
                middle: Text('Sub Screen'),
                leading: IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                        Navigator.of(context).pop();
                    },
                ),
            ),
            child: Center(
                child: Text('This is a sub screen.'),
            ),
        );
    }
}

class ModalScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                    transitionBetweenRoutes: false,
                    middle: Text('Modal Window'),
                    leading: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                            Navigator.of(context).pop();
                        },
                    ),
                ),
                child: Center(
                    child: Text('This is a modal window.'),
                ),
            ),
        );
    }
}

class SideMenu extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return CupertinoPageScaffold(
            child: Drawer(
                child: Column(
                    children: <Widget>[
                        Container(height:100),
                        ListTile(
                            title: Text('Modal Window'),
                            trailing: Icon(Icons.widgets),
                            onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) {
                                        return ModalScreen();
                                    },
                                    fullscreenDialog: true
                                ));
                            },
                        ),
                    ],
                )
            ),
        );
    }
}
