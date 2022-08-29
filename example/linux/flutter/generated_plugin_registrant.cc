//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flatlist_scroll/flatlist_scroll_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flatlist_scroll_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlatlistScrollPlugin");
  flatlist_scroll_plugin_register_with_registrar(flatlist_scroll_registrar);
}
