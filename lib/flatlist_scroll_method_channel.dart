import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flatlist_scroll_platform_interface.dart';

/// An implementation of [FlatlistScrollPlatform] that uses method channels.
class MethodChannelFlatlistScroll extends FlatlistScrollPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flatlist_scroll');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
