#include "script_component.hpp"

// check https://gist.github.com/Wolfenswan/82eb0019f2f3b0319ead

["Running Gear Export to CSV", 0] call BIS_fnc_3DENNotification;

_weapons = [];
_backpacks = [];
_magazines = [];
_glasses = [];

_magazines = [configfile >> "CfgMagazines"] call BIS_fnc_returnChildren;
_weapons = [configFile >> "CfgWeapons"] call BIS_fnc_returnChildren;
_backpacks = [configFile >> "CfgVehicles"] call BIS_fnc_returnChildren;
_glasses = [configFile >> "CfgGlasses"] call BIS_fnc_returnChildren;
_items = [configFile >> "CfgVehicles"] call BIS_fnc_returnChildren;

text "--- CONFIG DUMP CSV START ---" call FUNC(writeToFile);
text "name;type;class name;mod;mass;weight;capacity;armor;passthrough;magazines;ammo" call FUNC(writeToFile);

// Weapons and items (CfgWeapons)
{
	_configName = _x call FUNC(getClass);
	_name = getText(configFile >> "CfgWeapons" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgWeapons" >> _configName >> "picture");
	_scope = getText(configFile >> "CfgWeapons" >> _configName >> "scope");
	_mod = ["CfgWeapons", _configName] call FUNC(getMod);

	if (_name != "" && _picture != "" && _scope == 2) then {
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
		_magazines append _mags; // should be fine

		if(_type in ["PrimaryWeapon","SecondaryWeapon","Launcher"]) then {
			_mass = getNumber(configFile >> "CfgWeapons" >> _configName >> "WeaponSlotsInfo" >> "mass");
			_weight = round( ((_mass * 10) / 2.20462262185) * 1000 ); // weight in grams
			formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, _type, _classname, _mod, _mass, _weight, "N/A", "N/A", "N/A", _mags, "N/A"] call FUNC(writeToFile);
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

			_weight = round( ((_mass * 10) / 2.20462262185) * 1000 ); // weight in grams

			formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, _type, _classname, _mod, _mass, _weight, _capacity, _armor, _passthrough,  "N/A", "N/A"] call FUNC(writeToFile);
		};

	};
	
} forEach _weapons;

// Magazines (CfgMagazines)
{
	private ["_configName","_picture","_mass","_ammocount","_ammo"];
	_configName = _x call FUNC(getClass);
	
	_mod = ["CfgMagazines", _configName] call FUNC(getMod);
	_name = getText(configFile >> "CfgMagazines" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgMagazines" >> _configName >> "picture");
	_scope = getText(configFile >> "CfgWeapons" >> _configName >> "scope");
	
	if(_name != "" && _picture != "" && _scope == 2) then {
		_mass = getNumber(configFile >> "CfgMagazines" >> _configName >> "mass");
		_weight = round( ((_mass * 10) / 2.20462262185) * 1000 ); // weight in grams
		_ammocount = getNumber(configFile >> "CfgMagazines" >> _configName >> "count");
		_ammo = getText(configFile >> "CfgMagazines" >> _configName >> "ammo");
		
		formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, "magazine", _configName, _mod, _mass, _weight, _ammocount, "N/A", "N/A", "N/A", _ammo] call FUNC(writeToFile);
	};
} foreach _magazines;

// Backpacks (CfgVehicles)
{
	private ["_configName","_picture","_mass","_capacity"];
	_configName = _x call _getClass;
	_parents = [_x, true] call BIS_fnc_returnParents;

	_mod = ["CfgVehicles", _configName] call _getMod;
	_name = getText(configFile >> "CfgVehicles" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgVehicles" >> _configName >> "picture");
	_scope = getText(configFile >> "CfgWeapons" >> _configName >> "scope");
	
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
	) then {
			_mass = getNumber(configFile >> "CfgVehicles" >> _configName >> "mass");
			_weight = round( ((_mass * 10) / 2.20462262185) * 1000 ); // weight in grams
			_capacity = getNumber(configFile >> "CfgVehicles" >> _configName >> "maximumload");

		formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, "backpack", _configName, _mod, _mass, _weight, _capacity, "N/A", "N/A", "N/A", "N/A"] call FUNC(writeToFile);
	};
} foreach _backpacks;

// Facewear (CfgGlasses)
{
	private ["_configName","_picture","_mass"];
	_configName = _x call _getClass;

	_mod = ["CfgGlasses", _configName] call _getMod;
	_name = getText(configFile >> "CfgGlasses" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgGlasses" >> _configName >> "picture");
	_scope = getText(configFile >> "CfgGlasses" >> _configName >> "scope");
	_mass = getNumber(configFile >> "CfgGlasses" >> _configName >> "mass");
	_weight = round( ((_mass * 10) / 2.20462262185) * 1000 ); // weight in grams

	if (_name != "" && _picture != "" && _scope == 2) then {
		formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, "facewear", _configName, _mod, _mass, _weight, "N/A", "N/A", "N/A", "N/A", "N/A"] call FUNC(writeToFile);
	};
} foreach _glasses;



text "--- CONFIG DUMP CSV END ---" call FUNC(writeToFile);
hint ("unitaf_export_gear.csv" call FUNC(writeToFile));

["Gear Export to CSV Completed", 0] call BIS_fnc_3DENNotification;