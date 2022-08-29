import 'package:flutter_test/flutter_test.dart';
import 'package:flatlist_scroll/flatlist_scroll.dart';
import 'package:flatlist_scroll/flatlist_scroll_platform_interface.dart';
import 'package:flatlist_scroll/flatlist_scroll_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlatlistScrollPlatform 
    with MockPlatformInterfaceMixin
    implements FlatlistScrollPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlatlistScrollPlatform initialPlatform = FlatlistScrollPlatform.instance;

  test('$MethodChannelFlatlistScroll is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlatlistScroll>());
  });

}
