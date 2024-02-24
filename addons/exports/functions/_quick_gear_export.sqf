_writeToFile = {
	switch (typeName _this) do {
		case "STRING" : {
			_this = _this + "|" + (missionNamespace getVariable ["__temp", ""]);
			missionNamespace setVariable ["__temp", nil];
			"make_file" callExtension _this;
		};
		case "TEXT" : {
			missionNamespace setVariable [
				"__temp",
				(missionNamespace getVariable ["__temp", ""]) + str _this + "\n"
			];
		};
	};
};
_getClass = {
	if(typename _this == "STRING") then {
		_this;
	} else {
		configName _this;
	};
};
_getMod = {
	params ["_config", "_classname"];
	configSourceMod (configFile >> _config >> _classname);
};
_fixNumbers = {
	params ["_number"];
	[([_number] call BIS_fnc_numberText), "0123456789"] call BIS_fnc_filterString;
};
_shouldSkip = {
	params ["_modName", "_shouldSkip"];

	!(toLower _modName in ["", "enoch", "mark", "kart", "expansion", "orange", "argo", "jets", "heli", "tank"] && _shouldSkip);
};

["Running Gear Export to CSV", 0] call BIS_fnc_3DENNotification;

_skipVanilla = true;

_weapons = [];
_backpacks = [];
_magazines = [];
_glasses = [];

_magazines = [configfile >> "CfgMagazines"] call BIS_fnc_returnChildren;
_weapons = [configFile >> "CfgWeapons"] call BIS_fnc_returnChildren;
_backpacks = [configFile >> "CfgVehicles"] call BIS_fnc_returnChildren;
_glasses = [configFile >> "CfgGlasses"] call BIS_fnc_returnChildren;
_items = [configFile >> "CfgVehicles"] call BIS_fnc_returnChildren;

text "--- CONFIG DUMP CSV START ---" call _writeToFile;
text "name;type;class name;mod;mass;weight;capacity;armor;passthrough;magazines;ammo" call _writeToFile;

{
	_configName = _x call _getClass;
	_name = getText(configFile >> "CfgWeapons" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgWeapons" >> _configName >> "picture");
	_scope = getNumber(configFile >> "CfgWeapons" >> _configName >> "scope");
	_mod = ["CfgWeapons", _configName] call _getMod;

	if (_name != "" && _picture != "" && _scope == 2 && [_mod, _skipVanilla] call _shouldSkip) then {
		_parents = [_x, true] call BIS_fnc_returnParents;

		_type = switch true do {
			case ((configname inheritsFrom (Configfile >> "CfgWeapons" >> _configName >> "ItemInfo")) == "InventoryOpticsItem_Base_F"):			{"OpticAttachment"};
			case ((configname inheritsFrom (Configfile >> "CfgWeapons" >> _configName >> "ItemInfo")) == "InventoryMuzzleItem_Base_F" || getText(configFile >> "CfgWeapons" >> _configName >> "ItemInfo" >> "muzzleend") != ""):	{"MuzzleAttachment"};
			case ((configname inheritsFrom (Configfile >> "CfgWeapons" >> _configName >> "ItemInfo")) == "InventoryFlashLightItem_Base_F"):		{"SideAttachment"};
			case ("Rifle_Base_F" in _parents):																									{"PrimaryWeapon"};
			case ("Pistol" in _parents):																										{"SecondaryWeapon"};
			case ("Launcher" in _parents):																										{"Launcher"};
			case ((configname inheritsFrom (Configfile >> "CfgWeapons" >> _configName >> "ItemInfo")) == "HeadgearItem"):						{"HeadGear"};
			case ("HelmetBase" in _parents):																									{"HeadGear"};
			case ("H_HelmetB" in _parents):																										{"HeadGear"};
			case ("Uniform_Base" in _parents):																									{"Uniform"};
			case ((configname inheritsFrom (Configfile >> "CfgWeapons" >> _configName >> "ItemInfo")) == "UniformItem"):						{"Uniform"};
			case ("Vest_Camo_Base" in _parents || "Vest_NoCamo_Base" in _parents):																{"Vest"};
			case ((configname inheritsFrom (Configfile >> "CfgWeapons" >> _configName >> "ItemInfo")) == "VestItem"):							{"HeadGear"};
			case ("ItemCore" in _parents || "DetectorCore" in _parents):																		{"CommonItem"};
			case ("ItemMap" in _parents):																										{"Map"};
			case ("ItemWatch" in _parents):																										{"Watch"};
			case ("ItemCompass" in _parents):																									{"Compass"};
			case ("ItemGPS" in _parents):																										{"GPS"};
			case ("ItemRadio" in _parents):																										{"Radio"};
			case ("NVGoggles" in _parents || _configName == "NVGoggles"):																		{"NVGoggles"};
			case ("Binocular" in _parents):																										{"Binocular"};
			case ("CannonCore" in _parents):																									{"Cannon"};
			default 																															{"unknown"};
		};

		if (_type == "unknown") exitWith {systemChat ("Ignoring: " + _configName)};

		_classname = _configName;
		_mags = getArray(configFile >> "CfgWeapons" >> _configName >> "magazines");

		if(_type in ["PrimaryWeapon","SecondaryWeapon","Launcher"]) then {
			_mass = getNumber(configFile >> "CfgWeapons" >> _configName >> "WeaponSlotsInfo" >> "mass");
			_weight = [(round( ((_mass * 10) / 2.20462262185) * 1000 ))] call _fixNumber;
			formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, _type, _classname, _mod, _mass, _weight, "N/A", "N/A", "N/A", _mags, "N/A"] call _writeToFile;
		};

		if(_type != "unknown" && !(_type in ["PrimaryWeapon","SecondaryWeapon","Launcher"]) ) then {
			_mass = getNumber(configFile >> "CfgWeapons" >> _configName >> "ItemInfo" >> "mass");
			_capacity = getText(configFile >> "CfgWeapons" >> _configName >> "ItemInfo" >> "containerclass");

			if(_capacity != "") then {
				_capacity = getNumber(configFile >> "CfgVehicles" >> _capacity >> "maximumload");
			} else {
				_capacity = "N/A";
			};

			_armor = 0;
			switch (_type) do {
				case "HeadGear": {_armor = (getNumber(configFile >> "CfgWeapons" >> _configName >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "armor"))};
				case "Vest": {
					_armor = [];
					{
						_armor pushback (getNumber(configFile >> "CfgWeapons" >> _configName >> "ItemInfo" >> "HitpointsProtectionInfo" >> _x >> "armor"));
					} forEach ["Neck","Arms","Chest","Diaphragm","Abdomen","Body"];
				};
				default {_armor = "N/A"};
			};

			_passthrough = 0;
			switch (_type) do {
				case "HeadGear": {_passthrough = getNumber(configFile >> "CfgWeapons" >> _configName >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "passthrough")};
				case "Vest": {
					_passthrough = [];
					{
						_passthrough pushback (getNumber(configFile >> "CfgWeapons" >> _configName >> "ItemInfo" >> "HitpointsProtectionInfo" >> _x >> "passthrough"));
					} forEach ["Neck","Arms","Chest","Diaphragm","Abdomen","Body"];
				};
				default {_passthrough = "N/A"};
			};

			_weight = [(round( ((_mass * 10) / 2.20462262185) * 1000 ))] call _fixNumber;

			formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, _type, _classname, _mod, _mass, _weight, _capacity, _armor, _passthrough,  "N/A", "N/A"] call _writeToFile;
		};

	};
	
} forEach _weapons;

{
	private ["_configName","_picture","_mass","_ammocount","_ammo"];
	_configName = _x call _getClass;
	
	_mod = ["CfgMagazines", _configName] call _getMod;
	_name = getText(configFile >> "CfgMagazines" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgMagazines" >> _configName >> "picture");
	_scope = getNumber(configFile >> "CfgMagazines" >> _configName >> "scope");
	
	if(_name != "" && _picture != "" && _scope == 2 && [_mod, _skipVanilla] call _shouldSkip) then {
		_mass = getNumber(configFile >> "CfgMagazines" >> _configName >> "mass");
		_weight = [(round( ((_mass * 10) / 2.20462262185) * 1000 ))] call _fixNumber;
		_ammocount = getNumber(configFile >> "CfgMagazines" >> _configName >> "count");
		_ammo = getText(configFile >> "CfgMagazines" >> _configName >> "ammo");
		
		formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, "magazine", _configName, _mod, _mass, _weight, _ammocount, "N/A", "N/A", "N/A", _ammo] call _writeToFile;
	};
} foreach _magazines;

{
	private ["_configName","_picture","_mass","_capacity"];
	_configName = _x call _getClass;
	_parents = [_x, true] call BIS_fnc_returnParents;

	_mod = ["CfgVehicles", _configName] call _getMod;
	_name = getText(configFile >> "CfgVehicles" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgVehicles" >> _configName >> "picture");
	_scope = getNumber(configFile >> "CfgVehicles" >> _configName >> "scope");
	
	if (
			_name != ""
			&& _picture != ""
			&& _scope == 2
			&& !(
				count((configProperties [(configFile >> "CfgVehicles" >> _configName >> "TransportMagazines"), "isClass _x", true])) > 0
				|| count((configProperties [(configFile >> "CfgVehicles" >> _configName >> "TransportItems"), "isClass _x", true])) > 0
			)
			&& "Bag_Base" in _parents
			&& _configName != "Bag_Base"
			&& _name != "Bag"
			&& [_mod, _skipVanilla] call _shouldSkip
	) then {
			_mass = getNumber(configFile >> "CfgVehicles" >> _configName >> "mass");
			_weight = [(round( ((_mass * 10) / 2.20462262185) * 1000 ))] call _fixNumber;
			_capacity = getNumber(configFile >> "CfgVehicles" >> _configName >> "maximumload");

		formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, "backpack", _configName, _mod, _mass, _weight, _capacity, "N/A", "N/A", "N/A", "N/A"] call _writeToFile;
	};
} foreach _backpacks;

{
	private ["_configName","_picture","_mass"];
	_configName = _x call _getClass;

	_mod = ["CfgGlasses", _configName] call _getMod;
	_name = getText(configFile >> "CfgGlasses" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgGlasses" >> _configName >> "picture");
	_scope = getNumber(configFile >> "CfgGlasses" >> _configName >> "scope");
	_mass = getNumber(configFile >> "CfgGlasses" >> _configName >> "mass");
	_weight = [(round( ((_mass * 10) / 2.20462262185) * 1000 ))] call _fixNumber;

	if (_name != "" && _picture != "" && _scope == 2 && [_mod, _skipVanilla] call _shouldSkip) then {
		formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, "facewear", _configName, _mod, _mass, _weight, "N/A", "N/A", "N/A", "N/A", "N/A"] call _writeToFile;
	};
} foreach _glasses;

private _timeStamp = (systemTimeUTC apply { if (_x < 10) then { "0" + str _x } else { str _x } }) joinString "";
private _fileName = formatText ["unitaf_export_%1_%2.csv", "gear", _timeStamp];

text "--- CONFIG DUMP CSV END ---" call _writeToFile;
hint (_fileName call _writeToFile);

["Gear Export to CSV Completed", 0] call BIS_fnc_3DENNotification;