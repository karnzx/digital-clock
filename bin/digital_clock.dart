class Clock {
  final List<State> states = [Idle(), SettingHours(), SettingMins()];
  int currentState = 0;
  int currentHours = 0;
  int currentMins = 0;
  String get currentTime => '$currentHours:$currentMins';

  void turnOn([int hours = -1, int mins = -1]) {
    if (hours == -1 && mins == -1) {
      states[currentState].turnOn(this);
    } else {
      currentHours = hours;
      currentMins = mins;
      changeState(1);
    }
  }

  void set() {
    states[currentState].set(this);
  }

  void inc() {
    states[currentState].inc(this);
  }

  void changeState(int index) {
    currentState = index;
    if (index == 0) {
      showCurrentTime();
    } else if (index == 1) {
      print('beep');
      showHours();
    } else if (index == 2) {
      print('beep');
      showMins();
    }
  }

  void showCurrentTime() {
    print('Current Time is ${currentTime}');
  }

  void showHours() {
    print('Current Hours is ${currentHours}');
  }

  void showMins() {
    print('Current Mins is ${currentMins}');
  }
}

abstract class State {
  void turnOn(Clock clock) {
    print('error');
  }

  void set(Clock clock) {
    print('error');
  }

  void inc(Clock clock) {
    print('error');
  }
}

class Idle extends State {
  @override
  void turnOn(Clock clock) {
    clock.showCurrentTime();
  }

  @override
  void set(Clock clock) {
    clock.changeState(1);
  }
}

class SettingHours extends State {
  @override
  void set(Clock clock) {
    clock.changeState(2);
  }

  @override
  void inc(Clock clock) {
    clock.currentHours = (clock.currentHours + 1) % 24;
    clock.showHours();
  }
}

class SettingMins extends State {
  @override
  void set(Clock clock) {
    clock.changeState(0);
  }

  @override
  void inc(Clock clock) {
    clock.currentMins = (clock.currentMins + 1) % 60;
    clock.showMins();
  }
}

void main(List<String> arguments) {
  var msgs = [
    // 'on',
    'on 18 0',
    'set',
    'inc',
    'set',
    'inc',
    'set',
    'inc',
    'inc',
    'set'
  ];

  Clock clock = Clock();

  // if (msgs[0].split(' ').length > 1) {
  //   clock = Clock();
  //   print('with hour, mins');
  // }
  // msgs.removeAt(0);
  for (var msg in msgs) {
    // print('>> >>> $msg , ${clock.states[clock.currentState]}');
    if (msg.contains('on')) {
      if (msg.split(' ').length > 1) {
        var hours = int.parse(msg.split(' ')[1]);
        var mins = int.parse(msg.split(' ')[2]);
        clock.turnOn(hours, mins);
      } else {
        clock.turnOn();
      }
    } else if (msg == 'set') {
      clock.set();
    } else if (msg == 'inc') {
      clock.inc();
    }
  }
}
