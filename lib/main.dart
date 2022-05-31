
import 'package:flutter/material.dart';
import 'Shovel.dart';
import 'Bag.dart';
import 'Spot.dart';
import 'Shop.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<Spot>> diggedSpots = createSpots(7, 6);
  bool newFloor = true;
  Shovel shovel = Shovel();
  Bag bag = Bag();
  int floor = 0;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    if (newFloor){
      Spot.randomizer(diggedSpots);
      floor++;
      newFloor = false;
      bag.goldFoundInFloor = 0;
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(

        backgroundColor: Colors.brown[900],
        title: Text(
          "Dig!",
          style: TextStyle(
              fontFamily: 'MedievalSharp',
              letterSpacing: 1.5,
              color: Colors.yellowAccent[400]
          ),
        ),
        centerTitle: true,
      ),

      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton.icon( //Restart Button!
            onPressed: () {
              setState(() {
                newFloor = true;
                shovel.reset();
                bag.reset();
                floor = 0;
              });
            },
            icon: Icon(Icons.restart_alt),
            color: Colors.pinkAccent[400],
            label: Text(
              "Restart",
              style: TextStyle(
                fontFamily: 'MedievalSharp',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

          ),
          Row( // Digging Data!
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container( //gold, floor, durability, fix, "upgrade"
                    height: 20,
                    width: 170,
                    color: Colors.brown[800],
                    child: Text(
                      "Floor : ${floor}",
                      style: TextStyle(
                          fontFamily: 'MedievalSharp',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        color: Colors.lightGreenAccent[400],
                      ),
                    ),

                  ),
                  Container( //gold, floor, durability, fix, "upgrade"
                    height: 20,
                    width: 170,
                    color: Colors.brown[800],
                    child: Text(

                        "Lv.${shovel.level} Shovel Uses: ${shovel.durability}",
                        style: TextStyle(
                        fontFamily: 'MedievalSharp',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blueGrey[400],

                      ),
                    ),
                  ),

                  Container( //gold, floor, durability, fix, "upgrade"
                    height: 20,
                    width: 170,
                    color: Colors.brown[800],
                    child: Text(
                      "Gold : ${bag.gold}     -     ${bag.goldFoundInFloor}/5",
                      style: TextStyle(
                          fontFamily: 'MedievalSharp',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        color: Colors.yellowAccent[400],
                      ),
                    ),

                  ),
                  ]
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton( //gold, floor, durability, fix, "upgrade"
                      color: Colors.grey[800],
                      onPressed: () {
                        setState(() {
                          Shop.buyUpgrade(shovel, bag);
                        });
                      },
                      child: Text(
                        "Upgrade Shovel ~ 5Gold",
                        style: TextStyle(
                          fontFamily: 'MedievalSharp',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.amber[400],
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 10,
                      width: 30,

                    ),
                    RaisedButton( //gold, floor, durability, fix, "upgrade"
                      color: Colors.grey[800],
                      onPressed: () {
                        setState(() {
                          Shop.buyFix(shovel, bag);
                        });
                      },
                      child: Text(
                        "Fix Shovel ~ 3Gold",
                        style: TextStyle(
                          fontFamily: 'MedievalSharp',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueGrey[400],
                        ),
                      ),

                    )
                  ]
              )
            ],
          ),
          Expanded(
            child: Column( // Digging Field Creation
              mainAxisAlignment: MainAxisAlignment.center,

              children: diggedSpots.map((row) {
                return Expanded(child: Row( //row1 //
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.map((spot) {
                    return Expanded(child: FlatButton(onPressed: () {
                      setState(() {
                        newFloor = spot.dig(shovel, bag);
                      });
                    },
                    color: (spot.digged)? ((spot.hasGold)? Colors.yellowAccent[400] : ((spot.hasLadder)? Colors.lightGreenAccent[400] : Colors.grey[800])) : Colors.brown[900],

                    padding: EdgeInsets.all(20.0),
                    height: 1000,
                    minWidth: 60,
                    child:Text(" "),
                    ));

                  }).toList(),
                ));
              }).toList(),
            ),
          ),
        ],
      ),

    );
  }
}

List<List<Spot>> createSpots(int height, int width){
  List<List<Spot>> spots = [];
  for (int i = 0; i<height; i++){
    spots.add([]);
    for (int j = 0; j<width; j++){
      spots[i].add(Spot(hasGold: false, hasLadder: false));
    }
  }
  return spots;
}

