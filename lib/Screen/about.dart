import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        toolbarHeight: 45,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/blr.png"),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: MediaQuery.of(context).size.height*0.2,
                  decoration: BoxDecoration(
                    color: Color(0x1bcbcbcb),
                    borderRadius: BorderRadius.circular(250),
                    image: DecorationImage(
                        image: AssetImage("images/lgog.png"),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                      "DokuGomi",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width*0.06
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Text(
                      "\" Turn Your Trash Into Money \"\n\nV 0.1 Debug\n\nBy: Glenn",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width*0.04
                      ),
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
