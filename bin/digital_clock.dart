// on 18 0
// set
// inc
// set
// inc
// set
// inc
// inc
// set
class Clock {
  final List<State> states = [Idle(), SettingHours(), SettingMins()];
  final int currentState = 0;

  void turnOn() {
    states[currentState].turnOn(this);
  }

  void set() {
    states[currentState].set(this);
  }

  void inc() {
    states[currentState].inc(this);
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

class Idle extends State {}

class SettingHours extends State {}

class SettingMins extends State {}

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
    print(msgs);
  }
}
