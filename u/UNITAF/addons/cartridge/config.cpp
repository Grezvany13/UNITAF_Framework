#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            QMAIN_ADDON
        };
        author = ECSTRING(main,author);
        url = ECSTRING(main,url);
        VERSION_CONFIG;
    };
};


#include "CfgEventHandlers.hpp"
