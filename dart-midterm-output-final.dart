import 'dart:io';
import 'dart:math' show Random;
import 'package:emojis/emojis.dart'; // to use Emoji collection

void main() {
  var cont = 2, plyr, bot, conti, round;
  int plyrscore = 0, botscore = 0;

  for (int x = 0; x <= cont; x++) {
    round = x + 1;
    print('Round $round');
    Pick.getPrompt();
    String player = stdin.readLineSync(); //user input
    Pick pl = new Pick.plyrPick(player);
    print(pl.getUserPick());
    plyr = pl.userPickCase();
    pl.playerEmoji();

    bot = Pick.botPick();
    print('Bot: $bot');
    Pick bt = new Pick.btPick(bot);
    bt.botEmoji();

    Pick pb = Pick.userAndBot(plyr, bot);
    print(pb.conditions());
    print('.......');
    print(' ');

    plyrscore += pb.pscore;
    botscore += pb.bscore;

    if (x < 2) {
      continue;
    }
    print(
        "Do you wish to play another round? Enter 'Y' to continue. Enter any key to quit.");
    conti = stdin.readLineSync();
    if (conti == 'Y' || conti == 'y') {
      cont++;
    }
    print(' ');
  }
  cont = cont + 1;
  print('After $cont rounds...');
  Pick v = Pick.scores(botscore, plyrscore);
  v.printScores();
  v.printWinner();
}

class Pick {
  String userpick, botpick;
  int pscore = 0;
  int bscore = 0;

  Pick.plyrPick(this.userpick);
  Pick.btPick(this.botpick);
  Pick.scores(this.bscore, this.pscore);
  Pick.userAndBot(this.userpick, this.botpick);

  String printScores() {
    print('FINAL SCORE');
    print('Bot: $bscore, You: $pscore');
  }

  String printWinner() {
    if (pscore > bscore) {
      print('You win!');
    } else if (pscore < bscore) {
      print('Bot wins!');
    } else {
      print("It's a tie!");
    }
  }

  static String getPrompt() {
    print("Papel, Gunting, Bato! What's your pick?");
    print('${Emojis.raisedHand} ${Emojis.victoryHand} ${Emojis.raisedFist}');
  }

  String getUserPick() {
    return ('Your pick: $userpick');
  }

  String userPickCase() {
    return userpick.toLowerCase();
  }

  static String botPick() {
    var list = ['papel', 'gunting', 'bato'];
    final randpick = new Random();
    var bot1 = list[randpick.nextInt(list.length)];
    return bot1;
  }

  String conditions() {
    if ((userpick == 'bato' && botpick == 'gunting') ||
        (userpick == 'papel' && botpick == 'bato') ||
        (userpick == 'gunting' && botpick == 'papel')) {
      pscore += 1;
      return 'You win!';
    } else if ((botpick == 'bato' && userpick == 'gunting') ||
        (botpick == 'papel' && userpick == 'bato') ||
        (botpick == 'gunting' && userpick == 'papel')) {
      bscore += 1;
      return 'Bot wins, you lose!';
    } else if (userpick == botpick) {
      return "It's a tie!";
    } else {
      return 'Invalid user input!';
    }
  }

  String playerEmoji() {
    if (userpick == 'papel') {
      print('${Emojis.raisedHand}');
    } else if (userpick == 'gunting') {
      print('${Emojis.victoryHand}');
    } else if (userpick == 'bato') {
      print('${Emojis.raisedFist}');
    }
  }

  String botEmoji() {
    if (botpick == 'papel') {
      print('${Emojis.raisedHand}');
    } else if (botpick == 'gunting') {
      print('${Emojis.victoryHand}');
    } else if (botpick == 'bato') {
      print('${Emojis.raisedFist}');
    }
  }
}
