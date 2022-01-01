import 'package:flutter/material.dart';

import 'Forms.dart';

class Box extends StatelessWidget {
  const Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = "Cardboard";
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/blr.png"),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: Image.asset("images/box.png"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: SelectableText('Carboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xff61CF93)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: SelectableText('Why ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  margin: EdgeInsets.only(top: 10),
                  child: SelectableText('One of the most significant benefits of recycling cardboard is that it reduces the volume of waste sent to landfill. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Forms(name)),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 35),
                    width: 173,
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xff346D4F)
                    ),
                    child: Text('Sell Cardboard',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white
                      ),
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
