import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flatlist_scroll_method_channel.dart';

abstract class FlatlistScrollPlatform extends PlatformInterface {
  /// Constructs a FlatlistScrollPlatform.
  FlatlistScrollPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlatlistScrollPlatform _instance = MethodChannelFlatlistScroll();

  /// The default instance of [FlatlistScrollPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlatlistScroll].
  static FlatlistScrollPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlatlistScrollPlatform] when
  /// they register themselves.
  static set instance(FlatlistScrollPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
