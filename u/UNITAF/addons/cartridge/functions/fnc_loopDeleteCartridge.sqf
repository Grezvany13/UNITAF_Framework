#include "script_component.hpp"
/*
 * Author: Katalam
 * Deletes cartridge when there are too much of them.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call UNITAF_cartridge_fnc_loopDeleteCatridge;
 *
 * Public: No
 */

private _allPlayer = allPlayers select {isNull (getAssignedCuratorLogic _x)};
if (_allPlayer isEqualTo []) then {_allPlayer = allPlayers};
private _player = selectRandom _allPlayer;

private _types = missionNamespace getVariable [QGVAR(cartridges), []];

private _stop = QGVAR(stop) call CBA_settings_fnc_get;

private _cartridges = allSimpleObjects _types;
_cartridges = _cartridges select {((getPos _x) distance _player) > 1000};
if (_stop) then {
    _cartridges = allSimpleObjects _types;
};

// allowed amount on the ground
private _amount = QGVAR(amount) call CBA_settings_fnc_get;
if (_stop) then {
    _amount = 0;
};

private _tooMuch = count _cartridges - _amount;
_tooMuch = _tooMuch max 0;
if (_tooMuch > 0) then {
    for "_i" from 0 to _tooMuch do {
        deleteVehicle (_cartridges select _i);
    };
};
if (_stop) exitWith {};
[FUNC(loopDeleteCartridge), [], 60] call CBA_fnc_waitAndExecute;
