import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flatlist_scroll/flatlist_scroll_method_channel.dart';

void main() {
  MethodChannelFlatlistScroll platform = MethodChannelFlatlistScroll();
  const MethodChannel channel = MethodChannel('flatlist_scroll');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
