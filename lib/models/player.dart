import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class Player {

  String name = "Hrishyath";

  int level = 1;

  int currentXP = 0;
  int maxXP = 100;

  bool leveledUp = false;

  int STR = 5;
  int INT = 5;
  int CHA = 5;
  int VIT = 5;
  int DEX = 5;
  int WILL = 5;

  Player(){
    maxXP = calculateXP(level);
  }

  int calculateXP(int level){
    return (100 * pow(level, 1.5)).toInt();
  }

  void addXP(int xp){

    leveledUp = false;

    currentXP += xp;

    while(currentXP >= maxXP){

      currentXP -= maxXP;
      level++;
      maxXP = calculateXP(level);

      leveledUp = true;
    }
  }

  void addStats({
    int str = 0,
    int intStat = 0,
    int dex = 0,
    int vit = 0,
    int cha = 0,
    int will = 0,
  }){

    STR += str;
    INT += intStat;
    DEX += dex;
    VIT += vit;
    CHA += cha;
    WILL += will;
  }

  // ---------- STAT RANK SYSTEM ----------

  String statRank(int stat){

    if(stat >= 2000) return "S";
    if(stat >= 1500) return "A";
    if(stat >= 1000) return "B";
    if(stat >= 700) return "C";
    if(stat >= 400) return "D";
    if(stat >= 200) return "E";

    return "F";
  }

  // ---------- LEVEL TITLES ----------

  String get levelTitle{

    if(level >= 80) return "Grandmaster";
    if(level >= 50) return "Master";
    if(level >= 30) return "Veteran";
    if(level >= 20) return "Disciple";
    if(level >= 10) return "Trainee";

    return "Rookie";
  }

  // ---------- SAVE ----------

  Future<void> savePlayer() async {

    final prefs = await SharedPreferences.getInstance();

    prefs.setInt("level", level);
    prefs.setInt("currentXP", currentXP);
    prefs.setInt("maxXP", maxXP);

    prefs.setInt("STR", STR);
    prefs.setInt("INT", INT);
    prefs.setInt("DEX", DEX);
    prefs.setInt("VIT", VIT);
    prefs.setInt("CHA", CHA);
    prefs.setInt("WILL", WILL);
  }

  // ---------- LOAD ----------

  Future<void> loadPlayer() async {

    final prefs = await SharedPreferences.getInstance();

    level = prefs.getInt("level") ?? 1;
    currentXP = prefs.getInt("currentXP") ?? 0;
    maxXP = prefs.getInt("maxXP") ?? calculateXP(level);

    STR = prefs.getInt("STR") ?? 5;
    INT = prefs.getInt("INT") ?? 5;
    DEX = prefs.getInt("DEX") ?? 5;
    VIT = prefs.getInt("VIT") ?? 5;
    CHA = prefs.getInt("CHA") ?? 5;
    WILL = prefs.getInt("WILL") ?? 5;
  }

}