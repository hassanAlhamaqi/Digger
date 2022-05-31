import 'Bag.dart';
import 'Shovel.dart';

class Shop{
  static buyFix(Shovel shovel, Bag bag){
    if (bag.buy(3)){
     shovel.fix();
    }
  }
  static buyUpgrade(Shovel shovel, Bag bag){
    if (bag.buy(5)){
      shovel.upgrade();
    }
  }
}