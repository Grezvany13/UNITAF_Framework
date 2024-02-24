// only run when 3den menu is being shown
(findDisplay 313 displayCtrl 120) displayAddEventHandler ["onLoad", {
	params ["_displayOrControl", ["_config", configNull]];

	// remove CSV Export items when "make_file" doesn't exist
	_checkMakeFile = "make_file" callExtension "";
	if (_checkMakeFile === "") then {
		["Export to CSV not possible. Install 'make_file' for this feature", 1] call BIS_fnc_3DENNotification;
		// disable specific items
	}
}];