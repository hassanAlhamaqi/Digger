class Bag{
  int gold = 1;
  int goldFoundInFloor = 0;
  bool buy(int amount){
    if (gold - amount < 0){
      return false;
    }
    gold -= amount;
    return true;
  }
  void gainGold(){
    gold++;
    goldFoundInFloor++;
  }
  void reset(){
    gold = 1;
    goldFoundInFloor = 0;
  }
}