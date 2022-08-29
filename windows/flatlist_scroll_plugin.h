#ifndef FLUTTER_PLUGIN_FLATLIST_SCROLL_PLUGIN_H_
#define FLUTTER_PLUGIN_FLATLIST_SCROLL_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flatlist_scroll {

class FlatlistScrollPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlatlistScrollPlugin();

  virtual ~FlatlistScrollPlugin();

  // Disallow copy and assign.
  FlatlistScrollPlugin(const FlatlistScrollPlugin&) = delete;
  FlatlistScrollPlugin& operator=(const FlatlistScrollPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flatlist_scroll

#endif  // FLUTTER_PLUGIN_FLATLIST_SCROLL_PLUGIN_H_
