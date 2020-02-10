import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


var content = '~';
var added = '~';
var recipeTitle;
var recipeLink;
var coolingFeed = '~';
var weightFeed = '~';
var tempFeed = '~';
var humidFeed = '~';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Refrigerator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Smart Refrigerator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var response;
  @override
  void getData() async {
    print('Hello');
    // Cooling Feed
    response = await http.get(
        "https://io.adafruit.com/api/v2/shivamsingh25/feeds/cooling-meter/data?limit=1");
    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body)[0]['value']);
      setState(() => coolingFeed = json.decode(response.body)[0]['value']);
    }
    // Weight Feed
    response = await http.get(
        "https://io.adafruit.com/api/v2/shivamsingh25/feeds/weight/data?limit=1");
    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body)[0]['value']);
      setState(() => weightFeed = json.decode(response.body)[0]['value']);
    }
    // Temperature Feed
    response = await http.get(
        "https://io.adafruit.com/api/v2/shivamsingh25/feeds/ref-temperature/data?limit=1");
    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body)[0]['value']);
      setState(() => tempFeed = json.decode(response.body)[0]['value']);
    }
    // Humidity Feed
    response = await http.get(
        "https://io.adafruit.com/api/v2/shivamsingh25/feeds/ref-humidity/data?limit=1");
    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body)[0]['value']);
      setState(() => humidFeed = json.decode(response.body)[0]['value']);
    }
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    //bool isSwitched = true;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                getData();
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30.0,
                  ),
                  SizedBox(
                    child: new Text(
                      'Hey Shivam,',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w200),
                    ),
                  ),
                  // SizedBox(
                  //   child: new Text("Refrigerator Cooling",
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 20.0,
                  //         fontWeight: FontWeight.bold,
                  //       )),
                  // ),
                  // SizedBox(
                  //   width: 150.0,
                  // ),
                  // SizedBox(
                  //   child: Switch(
                  //     value: isSwitched,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         isSwitched = value;
                  //       });
                  //     },
                  //     activeTrackColor: Colors.indigoAccent,
                  //     activeColor: Colors.indigo,
                  //   ),
                  // ),
                ],
              )),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                child: new Text('Welcome to your smart refrigerator dashboard.',
                    style: new TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.w300)),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30.0,
                  ),
                  SizedBox(
                    width: 165.0,
                    height: 165.0,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      textColor: Colors.indigo,
                      color: Colors.white,
                      //splashColor: Colors.indigo[100],
                      onPressed: () => {},
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: new Text(
                              coolingFeed,
                              style: TextStyle(
                                fontSize: 100.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: new Text(
                              "Cooling",
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          SizedBox(
                            child: new Text(
                              "Min: 0 (OFF), Max: 5, Normal: 3",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 165.0,
                    height: 165.0,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      textColor: Colors.indigo,
                      color: Colors.white,
                      //splashColor: Colors.indigo[100],
                      onPressed: () => {},
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: new Text(
                              weightFeed,
                              style: TextStyle(
                                fontSize: 100.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: new Text(
                              "Grams",
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          SizedBox(
                            child: new Text(
                              "Refrigerator Contents",
                              style:
                                  TextStyle(fontSize: 13.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30.0,
                  ),
                  SizedBox(
                    width: 165.0,
                    height: 165.0,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      textColor: Colors.white,
                      color: Colors.indigo,
                      //splashColor: Colors.indigo[100],
                      onPressed: () => {},
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: new Text(
                              tempFeed,
                              style: TextStyle(
                                fontSize: 80.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: new Text(
                              "° Celcius",
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.grey[350]),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            child: new Text(
                              "Environment Temperature",
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 165.0,
                    height: 165.0,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      textColor: Colors.white,
                      color: Colors.indigo,
                      //splashColor: Colors.indigo[100],
                      onPressed: () => {},
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: new Text(
                              humidFeed,
                              style: TextStyle(
                                fontSize: 80.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: new Text(
                              "%",
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.grey[350]),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            child: new Text(
                              "Environment Humidity",
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                  child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30.0,
                  ),
                  SizedBox(
                    width: 165.0,
                    height: 50.0,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      textColor: Colors.indigo,
                      color: Colors.white,
                      elevation: 4.0,
                      //splashColor: Colors.indigo[100],
                      onPressed: () => {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ))
                          },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: new Text(
                              "Dashboard",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 165.0,
                    height: 50.0,
                    child: RaisedButton(
                      padding: const EdgeInsets.all(10.0),
                      textColor: Colors.indigo,
                      color: Colors.white,
                      elevation: 4.0,
                      //splashColor: Colors.indigo[100],
                      onPressed: () => {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => Live(),
                                ))
                          },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            child: new Text(
                              "Live",
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 350.0,
                height: 50.0,
                child: RaisedButton(
                  padding: const EdgeInsets.all(10.0),
                  textColor: Colors.white,
                  color: Colors.indigo,
                  elevation: 4.0,
                  onPressed: () => {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    Contents())) //RecipeList()))
                      },
                  child: new Text(
                    "Refrigerator Contents",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('AdaFruit IO Dashboard'),
      ),
      body: new WebView(
        initialUrl:
            'https://io.adafruit.com/shivamsingh25/dashboards/rpi-test1',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(builder:
        (BuildContext context, AsyncSnapshot<WebViewController> controller) {
      return FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      );
    });
  }
}

class Live extends StatefulWidget {
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Refrigerator Contents (Live)'),
      ),
      body: new WebView(
        initialUrl: 'http://192.168.1.102:8081',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(builder:
        (BuildContext context, AsyncSnapshot<WebViewController> controller) {
      return FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      );
    });
  }
}

class Contents extends StatefulWidget {
  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  var expRef = "Loading...";
  var category = "Loading...";
  var expFreezer = "Loading...";
  var createdAt = '~';
  void getContents() async {
    var link =
        "https://io.adafruit.com/api/v2/shivamsingh25/feeds/contents/data?limit=1";
    var response = await http.get(link);
    if (response.statusCode == 200) {
      debugPrint(json.decode(response.body)[0]['value']);
      setState(() => content = json.decode(response.body)[0]['value']);
      setState(() => createdAt = json.decode(response.body)[0]['created_at']);
      setState(() => added = createdAt.substring(0, 10));
    }

    link =
        "https://servers.shivamsr.com/api/refrigerator.php?food_item=${content}";
    response = await http.get(link);
    if (response.statusCode == 200) {
      //debugPrint(json.decode(response.body)[0]);
      if (json.decode(response.body)[0]['food'] != null) {
        setState(
            () => expRef = json.decode(response.body)[0]['refrigeratorExpiry']);
        setState(
            () => expFreezer = json.decode(response.body)[0]['freezerExpiry']);
        setState(() => category = json.decode(response.body)[0]['category']);
      } else {
        setState(() => expRef = "Unknown");
        setState(() => expFreezer = "Unknown");
        setState(() => category = "Unknown");
      }
    }
  }

  _launchURL() async {
    var url = 'https://calendar.google.com/calendar';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    getContents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text("Refrigerator Contents"),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                getContents();
              },
            )
          ],
        ),
        body: Container(
          child: Card(
            elevation: 8.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.kitchen,
                    color: Colors.indigo,
                    size: 50.0,
                  ),
                  title: Text(
                    content + ' - ' + weightFeed + ' grams',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      'Category: ${category} \n\nAdded: $added \n\nExpected Expiration/ Spoilage time: \n• Refrigerator: ${expRef}\n• Freezer: ${expFreezer}\n\nCheck Google Calendar for more details.'),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        child: Text('Google Calendar'),
                        onPressed: () {
                          _launchURL();
                        },
                      ),
                      RaisedButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        child: Text('Buy'),
                        onPressed: () {
                          _settingModalBottomSheet(context);
                        },
                      ),
                      RaisedButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        child: Text('Recipe'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => RecipeList()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(FontAwesomeIcons.amazon),
                  title: new Text('Amazon India'),
                  onTap: () => {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => AmazonSearch()))
                      }),
              new ListTile(
                leading: new Icon(Icons.shopping_cart),
                title: new Text('BigBasket'),
                onTap: () => {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => BigBasket()))
                    },
              ),
            ],
          ),
        );
      });
}

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  Map _recipeList = new Map();
  Map _recipe = new Map();
  void getRecipe(content, page) async {
    var link =
        "https://www.food2fork.com/api/search?key=619e17049a1b0faf00bc8ff01c894d39&q=${content}&page=${page}";

    var recipes = await http.get(link);
    if (recipes.statusCode == 200) {
      setState(() => _recipeList = json.decode(recipes.body));
      debugPrint(
          'Loaded ${_recipeList["count"]} Recipes from server for ${content}.');
      print(_recipeList["recipes"].length);
      // if(_recipeList["recipes"].length == 0){
      //   Navigator.push(context,
      //     new MaterialPageRoute(
      //       builder: (context) => NoRecipe()
      //     )
      //   );
      // }
    }
  }

  @override
  void initState() {
    getRecipe(content, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text("${content} Recipe List"),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.call_made),
              tooltip: 'All Recipe Page',
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => AllRecipePage()));
              },
            )
          ],
        ),
        body: new ListView.builder(
            itemCount: _recipeList["recipes"] == null
                ? 0
                : _recipeList["recipes"].length,
            itemBuilder: (BuildContext context, i) {
              return new ListTile(
                title: new Text(_recipeList["recipes"][i]["title"]),
                subtitle: new Text(_recipeList["recipes"][i]["publisher"]),
                leading: new CircleAvatar(
                  backgroundImage:
                      new NetworkImage(_recipeList["recipes"][i]["image_url"]),
                ),
                onTap: () {
                  recipeTitle = _recipeList["recipes"][i]["title"];
                  recipeLink = _recipeList["recipes"][i]["source_url"];
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => RecipePage()));
                },
              );
            }));
  }
}

class NoRecipe extends StatefulWidget {
  @override
  _NoRecipeState createState() => _NoRecipeState();
}

class _NoRecipeState extends State<NoRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("${content} Recipe List"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 160.0,
                height: 160.0,
                child: new Icon(Icons.sentiment_dissatisfied)),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              child: new Text("No Recipes found"),
            )
          ],
        ),
      ),
    );
  }
}

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(recipeTitle),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {
              Share.share('Check out this $content Recipe \n\n $recipeLink');
            },
          )
        ],
      ),
      body: new WebView(
        initialUrl: recipeLink,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(builder:
        (BuildContext context, AsyncSnapshot<WebViewController> controller) {
      return FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      );
    });
  }
}

class AmazonSearch extends StatefulWidget {
  @override
  _AmazonSearchState createState() => _AmazonSearchState();
}

class _AmazonSearchState extends State<AmazonSearch> {
  _launchURL() async {
    var url = 'https://www.amazon.in/s?k=${content}&ref=nb_sb_noss';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Amazon India'),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.launch),
            tooltip: 'Show in App',
            onPressed: () {
              _launchURL();
            },
          )
        ],
      ),
      body: new WebView(
        initialUrl: 'https://www.amazon.in/s?k=${content}&ref=nb_sb_noss',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(builder:
        (BuildContext context, AsyncSnapshot<WebViewController> controller) {
      return FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      );
    });
  }
}

class AllRecipePage extends StatefulWidget {
  @override
  _AllRecipePageState createState() => _AllRecipePageState();
}

class _AllRecipePageState extends State<AllRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('All Recipe: ${content}'),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {
              Share.share('Check out this $content Recipe \n\n https://www.allrecipes.com/search/results/?wt=${content}&sort=re');
            },
          )
        ],
      ),
      body: new WebView(
        initialUrl:
            'https://www.allrecipes.com/search/results/?wt=${content}&sort=re',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(builder:
        (BuildContext context, AsyncSnapshot<WebViewController> controller) {
      return FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      );
    });
  }
}

class BigBasket extends StatefulWidget {
  @override
  _BigBasketState createState() => _BigBasketState();
}

class _BigBasketState extends State<BigBasket> {
  _launchURL() async {
    var url = 'https://www.bigbasket.com/ps/?q=$content';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('BigBasket'),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.launch),
            tooltip: 'Show in App',
            onPressed: () {
              _launchURL();
            },
          )
        ],
      ),
      body: new WebView(
        initialUrl: 'https://www.bigbasket.com/ps/?q=${content}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(builder:
        (BuildContext context, AsyncSnapshot<WebViewController> controller) {
      return FloatingActionButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      );
    });
  }
}
