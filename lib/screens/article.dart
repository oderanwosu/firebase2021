import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        elevation: 3.0,
        title: Text("Article"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://miro.medium.com/max/6000/1*V7M6pgacOgFgLpE_MmPf4g.jpeg"),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Author",
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: (5 == 5)
                            ? Row(
                                children: [
                                  Center(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.blue),
                                      onPressed: () {},
                                      child: Text('Edit Article'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.red),
                                    onPressed: () {},
                                    child: Text('Delete Article'),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("text"),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
