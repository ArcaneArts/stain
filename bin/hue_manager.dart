import 'package:http/http.dart';
import 'package:hue_dart/hue_dart.dart';

import 'controlled_bridge.dart';

class HueManager {
  final Client _client = Client();
  final Map<String, ControlledBridge> _bridges = <String, ControlledBridge>{};
  BridgeDiscovery? _discovery;

  BridgeDiscovery discovery() {
    _discovery ??= BridgeDiscovery(_client);
    return _discovery!;
  }

  Future<void> connectToAll() async {
    List<DiscoveryResult> result = await discovery().automatic();

    for (final DiscoveryResult element in result) {
      await connectTo(element.ipAddress!);
    }
  }

  Future<void> connectTo(String ip) async {
    if (_bridges.containsKey(ip)) {
      return;
    }
    print("Connecting to bridge $ip");

    ControlledBridge cb = ControlledBridge(Bridge(_client, ip));
    cb.bridge.lights().then((value) => value.forEach((element) {
          print("-- Found light ${element.id}");
        }));
    _bridges[ip] = cb;
  }
}
