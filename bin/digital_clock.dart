class Clock {
  final List<State> states = [Idle(), SettingHours(), SettingMins()];
  int currentState = 0;
  int hours = 0;
  int mins = 0;
  String get currentTime => '$hours : $mins';

  void turnOn() {
    states[currentState].turnOn(this);
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
  }
}

class SettingHours extends State {
  @override
  void set(Clock clock) {
    clock.changeState(2);
  }

  @override
  void inc(Clock clock) {
    clock.hours = (clock.hours + 1) % 24;
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
  }
}

void main(List<String> arguments) {
  List<String> msgs = [
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
  for (var msg in msgs) {
    print(msg);
  }
}
