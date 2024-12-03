import 'hue_manager.dart';

void main(List<String> arguments) {
  doStuffContinually();
}

Future<void> doStuffContinually() async {
  HueManager man = HueManager();

  while (true) {
    print("Connecting to all...");
    await man.connectToAll();
    await Future.delayed(Duration(seconds: 10), () {});
  }
}
