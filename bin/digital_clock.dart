class Clock {
  final List<State> states = [Idle(), SettingHours(), SettingMins()];
  int currentState = 0;
  int hours = 0;
  int mins = 0;
  String get currentTime => '$hours : $mins';

  void turnOn([int? hours, int? mins]) {
    if (hours is null && mins is null){
      currentState = 1;
    }else{
      states[currentState].turnOn(this);
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
    print(clock.currentTime);
  }

  @override
  void set(Clock clock) {
    clock.changeState(1);
    print('beep');
    print(clock.hours);
  }
}

class SettingHours extends State {
  @override
  void set(Clock clock) {
    clock.changeState(2);
    print('beep');
    print(clock.mins);
  }

  @override
  void inc(Clock clock) {
    clock.hours = (clock.hours + 1) % 24;
    print(clock.hours);
  }
}

class SettingMins extends State {
  @override
  void set(Clock clock) {
    clock.changeState(0);
  }

  @override
  void inc(Clock clock) {
    clock.mins = (clock.mins + 1) % 60;
    print(clock.mins);
  }
}

void main(List<String> arguments) {
  List<String> msgs = [
    'on 18 0',
    // 'on',
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
    print('>>>>> $msg , ${clock.states[clock.currentState]}');
    if (msg.contains('on')) {
      if (msg.split(' ').length > 1) {
        int hours = int.parse(msg.split(' ')[1]);
        int mins = int.parse(msg.split(' ')[2]);
        clock.turnOn(hours,mins);
      } else {
        clock.turnOn();
      }
    } else if (msg == 'set') {
      clock.set();
    } else if (msg == 'inc') {
      clock.inc();
    }
    // print('>>>>> ${clock.states[clock.currentState]}');
  }
}
