import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/src/white/game_page.dart';


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> with SingleTickerProviderStateMixin {

  final myNewFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.black, letterSpacing: 3)
  );
  final myNewFontwhite = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3)
  );

  AudioPlayer audioPlayer = AudioPlayer();
  bool isSoundOn = true;
  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }
  
  void _playBackgroundMusic() async {
    await audioPlayer.play(AssetSource('music.mp3'));
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  void _toggleSound() {
    setState(() {
      isSoundOn = !isSoundOn;
      if (isSoundOn) {
        _playBackgroundMusic();
      } else {
        audioPlayer.stop();
      }
    });
  }


  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  SafeArea(
                    child: GestureDetector(
                      onTap: _toggleSound,
                      child: Icon(
                        isSoundOn ? Icons.volume_up : Icons.volume_off,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Container(
                child: Text('Ping Pang Poe',
                  style: myNewFontwhite.copyWith(fontSize: 25),
                )
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: AvatarGlow(
                  endRadius: 180,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 1),
                  startDelay: Duration(seconds: 1),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        style: BorderStyle.none
                      ),
                      shape: BoxShape.circle
                    ),
                    child: CircleAvatar(
                       backgroundColor: Colors.grey[900],
                      radius: 110,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/logo.png',
                        ),
                      ),
                    ),
                  ),  
                )
              )
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>GamePage())
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 40,right: 40, bottom: 60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    color: Colors.white,
                    child: Center(
                      child: Text('PLAY GAME', style: myNewFont),
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


