#import "FlatlistScrollPlugin.h"
#if __has_include(<flatlist_scroll/flatlist_scroll-Swift.h>)
#import <flatlist_scroll/flatlist_scroll-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flatlist_scroll-Swift.h"
#endif

@implementation FlatlistScrollPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlatlistScrollPlugin registerWithRegistrar:registrar];
}
@end
