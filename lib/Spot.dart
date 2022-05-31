import 'Shovel.dart';
import 'Bag.dart';
import 'dart:math';

class Spot{
  bool digged = false;
  late bool hasGold;
  late bool hasLadder;

  Spot({required this.hasGold, required this.hasLadder});

  bool dig(Shovel shovel, Bag bag) {
    if ((!digged) && (shovel.durability>0)){
      digged = true;
      shovel.dig();
    }
    else if (digged) {
      if(hasGold){
        bag.gainGold();
        hasGold = false;

      }
      else if(hasLadder){
        return true;
      }
    }
    return false;
  }

  static void resetAll(List<List<Spot>> spots){
    for (int i = 0; i<spots.length; i++){
      for (int j = 0; j<spots[0].length; j++){
        spots[i][j].digged = false;
        spots[i][j].hasGold = false;
        spots[i][j].hasLadder = false;
        }
    }
  }

  static void randomizer(List<List<Spot>> spots){
    resetAll(spots);
    var rng = Random();
    int amount = 0;
    int size = spots.length*spots[0].length;
    int row;
    int column;
    while (amount!=6){
      row = rng.nextInt(spots.length);
      column = rng.nextInt(spots[0].length);
      if (!spots[row][column].hasGold){
        amount++;
        if (amount!=6){
          spots[row][column].hasGold = true;
        }
        else{
          spots[row][column].hasLadder = true;
        }

      }
    }
  }
}