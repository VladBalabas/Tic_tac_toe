import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/src/white/comp/methods/my_button.dart';

import 'initial_page.dart';
//import 'package:audioplayers/audioplayers.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> displayExOh = ['','','','','','','','',''];
  bool roundEnded=false;
  bool ohTurn = false;
  int exScore = 0;
  int ohScore = 0;
  int filledboxes=0;
  final myNewFontWhite = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 16)
  );
  final myNewFontBlack = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.black, fontSize: 13)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InitialPage()));},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Main menu',
                            style: myNewFontWhite.copyWith(
                                fontSize: 13, 
                                letterSpacing: 0,
                                decoration: TextDecoration.underline
                              ),
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Player:X', style: myNewFontWhite,),
                  const SizedBox(height: 20,),
                  Text(exScore.toString(), style: myNewFontWhite,)
                ],
              ),
              const SizedBox(width: 20,),
              Column(
                children: [
                  Text('Computer:O', style: myNewFontWhite,),
                  const SizedBox(height: 20,),
                  Text(ohScore.toString(), style: myNewFontWhite,)
                ],
              ),
            ],
          ),  
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: 
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){_tapped(index);},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 97, 97, 97))
                        ),
                        child: Center(
                          child: Text(displayExOh[index], 
                            style: const TextStyle(
                              color: Colors.white, 
                              fontSize: 40
                            ),
                          )
                        ),
                      ),
                    );
                  },
                ),
            ),
          ),
          Expanded(  
            child: Column(
              children:[
                const SizedBox(height: 20,),
                Text('First to 5 - wins!', style: myNewFontWhite,),
                const SizedBox(height: 40,),
                
              ]
            )
          ), 
        ],
      ),
    );
  }

  void _tapped(int index){
  setState(() {
    if(displayExOh[index] == '') {
      displayExOh[index] = 'X';
      filledboxes++;
      _checkWinner();
      if (filledboxes < 9&&!roundEnded) {
        _computerTurn();
      }
      
    }
  });
}

void _computerTurn() {
  int index= 4;
  while (displayExOh[index]!=''){
    index = Random().nextInt(9);
  }
    displayExOh[index] = 'O';
    filledboxes++;
    _checkWinner();
  
}

  void _checkWinner(){
    if (displayExOh[0]==displayExOh[1]&&
        displayExOh[0]==displayExOh[2]&& 
        displayExOh[0]!='')
        {_showWinDialog(displayExOh[0]); roundEnded=true; return;}

    if (displayExOh[3]==displayExOh[4]&&
        displayExOh[3]==displayExOh[5]&& 
        displayExOh[3]!='')
        {_showWinDialog(displayExOh[3]);roundEnded=true; return;}

    if (displayExOh[6]==displayExOh[7]&&
        displayExOh[6]==displayExOh[8]&& 
        displayExOh[6]!='')
        {_showWinDialog(displayExOh[6]);roundEnded=true; return;}

    if (displayExOh[0]==displayExOh[3]&&
        displayExOh[0]==displayExOh[6]&& 
        displayExOh[0]!='')
        {_showWinDialog(displayExOh[0]);roundEnded=true; return;}

    if (displayExOh[1]==displayExOh[4]&&
        displayExOh[1]==displayExOh[7]&& 
        displayExOh[1]!='')
        {_showWinDialog(displayExOh[1]);roundEnded=true; return;}

    if (displayExOh[2]==displayExOh[5]&&
        displayExOh[2]==displayExOh[8]&& 
        displayExOh[2]!='')
        {_showWinDialog(displayExOh[2]);roundEnded=true; return;}

    if (displayExOh[0]==displayExOh[4]&&
        displayExOh[0]==displayExOh[8]&& 
        displayExOh[0]!='')
        {_showWinDialog(displayExOh[0]);roundEnded=true; return;}

    if (displayExOh[2]==displayExOh[4]&&
        displayExOh[2]==displayExOh[6]&& 
        displayExOh[2]!='')
        {_showWinDialog(displayExOh[2]);roundEnded=true; return;}  
      
    if(filledboxes==9){
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: (exScore==5||ohScore==5)
            ?Text('$winner won the game!', style: myNewFontWhite.copyWith(fontSize: 15),textAlign: TextAlign.center)
            :Text('Winner is $winner', style: myNewFontWhite.copyWith(fontSize: 15),textAlign: TextAlign.center),
          backgroundColor: Colors.grey[600],
          actions: [
            if (exScore==5||ohScore==5)
            MyButton(
              onTap: (){
              setState(() {
                  exScore=0;
                  ohScore=0;
                });
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text('Restart game',style: myNewFontBlack), 
              height: 50, 
              width: double.infinity
            ),
            if (exScore<5&&ohScore<5) 
            MyButton(
              onTap: (){
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text('Play again',style: myNewFontBlack), 
              height: 50, 
              width: double.infinity
            ),
          ],
        );
      },
    );
    
    if(winner=='O'){
      setState(() {
        ohScore+=1;
      });
    }
    else if (winner=='X'){
      setState(() {
        exScore+=1;
      });
    }
  }

  void _showDrawDialog(){
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DRAW', style: myNewFontWhite,textAlign: TextAlign.center),
          backgroundColor: Colors.grey[600],
          actions: [
                        MyButton(
              onTap: (){
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: Text('Play again',style: myNewFontBlack), 
              height: 50, 
              width: double.infinity
            ),
          ],
        );
      },
    );
  }
  void _clearBoard(){
    setState(() {
      for(int i=0;i<9;i++){
        displayExOh[i]='';
      }
      filledboxes=0;
      roundEnded=false;
    });
  }
}

