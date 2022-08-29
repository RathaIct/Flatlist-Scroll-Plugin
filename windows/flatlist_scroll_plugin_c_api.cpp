#include "include/flatlist_scroll/flatlist_scroll_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flatlist_scroll_plugin.h"

void FlatlistScrollPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flatlist_scroll::FlatlistScrollPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
