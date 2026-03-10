import 'package:flutter/material.dart';
import '../models/player.dart';
import '../widgets/stat_tile.dart';

const Color systemRed = Color(0xFFFF3B3B);
const Color rankColor = Color(0xFFB0B3C6);

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  Player player = Player();

  double get progress => (player.currentXP / player.maxXP).clamp(0, 1);

  @override
  void initState() {
    super.initState();
    loadPlayer();
  }

  void loadPlayer() async {
    await player.loadPlayer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0B0F1A),

      floatingActionButton: FloatingActionButton(
        backgroundColor: systemRed,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showAddPointsDialog();
        },
      ),

      body: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: systemRed, width: 2),
            boxShadow: [
              BoxShadow(
                color: systemRed.withOpacity(0.35),
                blurRadius: 20,
              )
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                "STATUS",
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  color: systemRed,
                ),
              ),

              Text(
                player.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Text(
                player.levelTitle,
                style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 2,
                  color: Color(0xFF8C6A3E),
                ),
              ),

              SizedBox(height: 20),

              const SizedBox(height: 20),

              Text(
                player.level.toString(),
                style: const TextStyle(
                  fontSize: 48,
                  color: systemRed,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                "LEVEL",
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 25),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("EXP"),

                  const SizedBox(height: 6),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.white12,
                    color: systemRed,
                  ),

                  const SizedBox(height: 4),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${player.currentXP} / ${player.maxXP}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatTile(
                    name: "STR",
                    value: player.STR,
                    rank: player.statRank(player.STR),
                  ),
                  StatTile(
                    name: "VIT",
                    value: player.VIT,
                    rank: player.statRank(player.VIT),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatTile(
                    name: "INT",
                    value: player.INT,
                    rank: player.statRank(player.INT),
                  ),
                  StatTile(
                    name: "CHA",
                    value: player.CHA,
                    rank: player.statRank(player.CHA),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatTile(
                    name: "DEX",
                    value: player.DEX,
                    rank: player.statRank(player.DEX),
                  ),
                  StatTile(
                    name: "WILL",
                    value: player.WILL,
                    rank: player.statRank(player.WILL),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddPointsDialog() {

    TextEditingController xp = TextEditingController();
    TextEditingController str = TextEditingController();
    TextEditingController intStat = TextEditingController();
    TextEditingController dex = TextEditingController();
    TextEditingController vit = TextEditingController();
    TextEditingController cha = TextEditingController();
    TextEditingController will = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text("Gain Points"),

          content: SingleChildScrollView(
            child: Column(
              children: [

                inputField("EXP", xp),
                inputField("STR", str),
                inputField("INT", intStat),
                inputField("DEX", dex),
                inputField("VIT", vit),
                inputField("CHA", cha),
                inputField("WILL", will),

              ],
            ),
          ),

          actions: [

            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),

            ElevatedButton(
                child: const Text("Apply"),
                onPressed: () async {

                  int xpValue = int.tryParse(xp.text) ?? 0;
                  int strValue = int.tryParse(str.text) ?? 0;
                  int intValue = int.tryParse(intStat.text) ?? 0;
                  int dexValue = int.tryParse(dex.text) ?? 0;
                  int vitValue = int.tryParse(vit.text) ?? 0;
                  int chaValue = int.tryParse(cha.text) ?? 0;
                  int willValue = int.tryParse(will.text) ?? 0;

                  bool leveled = false;

                  setState(() {
                    player.addXP(xpValue);
                    leveled = player.leveledUp;

                    player.addStats(
                      str: strValue,
                      intStat: intValue,
                      dex: dexValue,
                      vit: vitValue,
                      cha: chaValue,
                      will: willValue,
                    );
                  });

                  // Clear fields before closing
                  xp.clear();
                  str.clear();
                  intStat.clear();
                  dex.clear();
                  vit.clear();
                  cha.clear();
                  will.clear();

                  Navigator.pop(context); // close dialog instantly

                  if (leveled && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("LEVEL UP! Now Level ${player.level}"),
                      ),
                    );
                  }

                  // Save in background
                  await player.savePlayer();
                }
            )
          ],
        );
      },
    );
  }

  Widget inputField(String label, TextEditingController controller) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,

        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}