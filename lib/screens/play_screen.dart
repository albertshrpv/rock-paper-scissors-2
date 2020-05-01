import 'package:flutter/material.dart';
import 'package:rps/widgets/pdwe_raised_button.dart';

enum Move {
  Rock,
  Paper,
  Scissors,
  Fire,
  Snake,
  Human,
  Tree,
  Wolf,
  Sponge,
  Air,
  Water,
  Dragon,
  Devil,
  Lightning,
  Gun
}

class PlayScreen extends StatefulWidget {
  static const routeName = '/play';

  final socket;
  final data;

  PlayScreen(this.socket, this.data);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  Move chosenMove;
  Move opponentMove;
  bool locked = false;
  int wins = 0;
  String opponent = '';

  @override
  void initState() {
    super.initState();
    try {
      widget.socket.connect();
      widget.socket.emit('join_room', widget.data['room']);

      widget.socket.on('play', (data) {
        print('ON PLAY');
        print(data);
        if (this.mounted) {
          setState(() {
            if (data['name'] != widget.data['name']) {
              setState(() {
                opponentMove = movesMap[data['move']];
                opponent = data['name'];
              });
            }
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  final List<Move> movesList = [
    Move.Paper,
    Move.Rock,
    Move.Scissors,
    Move.Air,
    Move.Devil,
    Move.Dragon,
    Move.Fire,
    Move.Gun,
    Move.Human,
    Move.Lightning,
    Move.Snake,
    Move.Sponge,
    Move.Tree,
    Move.Water,
    Move.Wolf
  ];

  final Map<Move, dynamic> moves = {
    Move.Rock: {
      'name': 'Rock',
      'color': Colors.brown,
      'wins': [Move.Fire, Move.Snake, Move.Human, Move.Tree, Move.Scissors, Move.Sponge, Move.Gun],
      'loses': [Move.Paper, Move.Devil, Move.Lightning, Move.Water, Move.Air]
    },
    Move.Fire: {
      'name': 'Fire',
      'color': Colors.redAccent,
      'wins': [Move.Snake, Move.Human, Move.Tree, Move.Wolf, Move.Gun, Move.Paper, Move.Lightning],
      'loses': [Move.Rock, Move.Air, Move.Water, Move.Dragon, Move.Devil],
    },
    Move.Snake: {
      'name': 'Snake',
      'color': Colors.lightGreen,
      'wins': [Move.Human, Move.Scissors, Move.Water, Move.Devil, Move.Dragon],
      'loses': [Move.Rock, Move.Fire, Move.Lightning, Move.Gun, Move.Paper, Move.Air]
    },
    Move.Human: {
      'name': 'Human',
      'color': Colors.pinkAccent,
      'wins': [Move.Scissors, Move.Paper, Move.Tree, Move.Sponge, Move.Air],
      'loses': [Move.Rock, Move.Fire, Move.Snake, Move.Lightning, Move.Water, Move.Air, Move.Devil, Move.Gun]
    },
    Move.Tree: {
      'name': 'Tree',
      'color': Colors.greenAccent,
      'wins': [Move.Gun, Move.Water, Move.Paper, Move.Wolf, Move.Scissors],
      'loses': [Move.Rock, Move.Fire, Move.Human, Move.Dragon, Move.Air, Move.Lightning]
    },
    Move.Scissors: {
      'name': 'Scissors',
      'color': Colors.lightBlue,
      'wins': [Move.Paper, Move.Wolf, Move.Sponge, Move.Devil, Move.Dragon, Move.Lightning],
      'loses': [Move.Rock, Move.Snake, Move.Human, Move.Tree, Move.Water, Move.Air]
    },
    Move.Wolf: {
      'name': 'Wolf',
      'color': Colors.purpleAccent,
      'wins': [Move.Sponge, Move.Paper, Move.Devil, Move.Water, Move.Air],
      'loses': [Move.Fire, Move.Tree, Move.Scissors, Move.Lightning, Move.Gun, Move.Paper, Move.Dragon]
    },
    Move.Sponge: {
      'name': 'Sponge',
      'color': Colors.yellowAccent,
      'wins': [Move.Water, Move.Paper],
      'loses': [Move.Human, Move.Scissors, Move.Wolf, Move.Air, Move.Rock, Move.Devil]
    },
    Move.Air: {
      'name': 'Air',
      'color': Colors.white,
      'wins': [Move.Rock, Move.Fire, Move.Tree, Move.Scissors, Move.Sponge, Move.Paper, Move.Lightning, Move.Gun],
      'loses': [Move.Human, Move.Wolf, Move.Water, Move.Snake, Move.Human, Move.Dragon],
    },
    Move.Water: {
      'name': 'Water',
      'color': Colors.blue,
      'wins': [Move.Rock, Move.Fire, Move.Human, Move.Scissors, Move.Gun, Move.Paper, Move.Dragon, Move.Lightning],
      'loses': [Move.Snake, Move.Tree, Move.Wolf, Move.Sponge, Move.Air]
    },
    Move.Paper: {
      'name': 'Paper',
      'color': Colors.grey,
      'wins': [Move.Rock, Move.Snake, Move.Sponge, Move.Wolf, Move.Devil],
      'loses': [Move.Scissors, Move.Human, Move.Tree, Move.Wolf, Move.Fire, Move.Air, Move.Water, Move.Lightning]
    },
    Move.Dragon: {
      'name': 'Water',
      'color': Colors.blue,
      'wins': [Move.Fire, Move.Tree, Move.Human, Move.Wolf, Move.Air],
      'loses': [Move.Snake, Move.Scissors, Move.Water, Move.Devil, Move.Gun]
    },
    Move.Devil: {
      'name': 'Devil',
      'color': Colors.red,
      'wins': [Move.Rock, Move.Fire, Move.Lightning, Move.Sponge, Move.Dragon, Move.Human],
      'loses': [Move.Snake, Move.Scissors, Move.Wolf, Move.Paper, Move.Gun],
    },
    Move.Lightning: {
      'name': 'Lightning',
      'color': Colors.amberAccent,
      'wins': [Move.Rock, Move.Snake, Move.Human, Move.Wolf, Move.Tree, Move.Paper],
      'loses': [Move.Devil, Move.Fire, Move.Water, Move.Air, Move.Scissors]
    },
    Move.Gun: {
      'name': 'Gun',
      'color': Colors.amber,
      'wins': [Move.Snake, Move.Wolf, Move.Dragon, Move.Human, Move.Devil],
      'loses': [Move.Fire, Move.Tree, Move.Water, Move.Air, Move.Rock],
    },
  };

  final Map<String, Move> movesMap = {
    'Paper': Move.Paper,
    'Rock': Move.Rock,
    'Scissors': Move.Scissors,
    'Fire': Move.Fire,
    'Snake': Move.Snake,
    'Human': Move.Human,
    'Tree': Move.Tree,
    'Wolf': Move.Wolf,
    'Sponge': Move.Sponge,
    'Air': Move.Air,
    'Water': Move.Water,
    'Dragon': Move.Dragon,
    'Devil': Move.Devil,
    'Lightning': Move.Lightning,
    'Gun': Move.Gun
  };

  String checkWin(move, oppMove) {
    if (moves[move]['wins'].contains(oppMove)) {
      return 'Gewonnen!';
    } else if (moves[move]['loses'].contains(oppMove)) {
      return 'Verloren :(';
    } else {
      return 'Unentschieden.';
    }
  }

  Widget _buildMoveCard(Move move) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            chosenMove = move;
          });
        },
        child: Container(
          margin: EdgeInsets.all(5),
          // height: 30,
          // width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: moves[move]['color'],
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.black38,
                spreadRadius: 1,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Center(
              child: Text(
            moves[move]['name'],
            style: TextStyle(
              color: moves[move]['color'] == Colors.white ||
                      moves[move]['color'] == Colors.yellowAccent
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (opponentMove != null) {
      print(moves[opponentMove]['name']);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Spielen')),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 50,
              child: Center(child: Text('Dein Move')),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: chosenMove == null
                  ? Center(child: Text('Wähle einen Move!'))
                  : Center(child: _buildMoveCard(chosenMove)),
            ),
            if (!locked)
              PdweRaisedButton(() {
                if (chosenMove != null) {
                  setState(() {
                    locked = true;
                  });
                  widget.socket.emit('play', {
                    'room': widget.data['room'],
                    'name': widget.data['name'],
                    'move': moves[chosenMove]['name'],
                  });
                }
              }, 'Bestätigen'),
            SizedBox(
              height: 10,
            ),
            Divider(),
            (locked)
                ? opponentMove == null
                    ? Container(
                        child: Center(
                          child: Text('warte auf Gegner'),
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Text('$opponent'),
                            ),
                          ),
                          Container(
                            height: 100,
                            child: Center(
                              child: _buildMoveCard(opponentMove),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            child: Center(
                              child: Text(checkWin(chosenMove, opponentMove)),
                            ),
                          ),
                          PdweRaisedButton(() {
                            setState(() {
                              chosenMove = null;
                              opponentMove = null;
                              locked = false;
                            });
                          }, 'erneut')
                        ],
                      )
                : Flexible(
                    child: GridView.builder(
                      itemCount: movesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        return _buildMoveCard(movesList[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
