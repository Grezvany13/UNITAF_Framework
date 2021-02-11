[
    QGVAR(amount),
    "SLIDER", // type of setting
    "Max cartridge amount",
    [QUOTE(PREFIX), QUOTE(COMPONENT_BEAUTIFIED)],
    [0, 1000, 500, 0],
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(stop),
    "CHECKBOX", // type of setting
    "Stop cartridge creating",
    [QUOTE(PREFIX), QUOTE(COMPONENT_BEAUTIFIED)],
    true,
    true
] call CBA_Settings_fnc_init;
