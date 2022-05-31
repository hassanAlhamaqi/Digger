class Shovel{
  int durability = 22;
  int level = 1;
  void upgrade() {
    level++;
    this.fix();
  }
  void fix(){
    durability = 19 + level*3;
  }
  void dig(){
    durability--;
  }
  void reset(){
    level = 1;
    durability = 19 + level*3;
  }
}