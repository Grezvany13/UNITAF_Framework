#include "script_component.hpp"

["Running Vehicle Export to CSV", 0] call BIS_fnc_3DENNotification;

_vehicles = [];

_vehicles = [configFile >> "CfgVehicles"] call BIS_fnc_returnChildren;

text "--- CONFIG DUMP CSV START ---" call FUNC(writeToFile);
text "name;type;class name;mod;mass;weight;crew slots;cargo slots" call FUNC(writeToFile);

{
	private ["_configName"];
	
	_configName = _x call FUNC(getClass);
	_name = getText(configFile >> "CfgVehicles" >> _configName >> "displayname");
	_picture = getText(configFile >> "CfgVehicles" >> _configName >> "picture");
	_scope = getText(configFile >> "CfgVehicles" >> _configName >> "scope");

	if(_name != "" && _picture != "" && _scope == 2) then {
		_parents = [_x, true] call BIS_fnc_returnParents;

		_type = switch true do {
			case ("Wheeled_APC_F" in _parents || "Wheeled_APC" in _parents):															{"Wheeled APC"};
			case ("APC_Tracked_01_base_F" in _parents || "APC_Tracked_02_base_F" in _parents || "APC_Tracked_03_base_F" in _parents):	{"Tracked APC"};
			case ("VTOL_Base_F" in _parents):    																						{"VTOL"};
			case ("UAV_01_base_F" in _parents || "UAV_02_base_F" in _parents || "UAV_03_base_F" in _parents || "UAV_04_base_F" in _parents || "UAV_05_base_F" in _parents || "UAV_06_base_F" in _parents):    {"UAV"};
			case ("UGV_01_base_F" in _parents || "UGV_02_base_F" in _parents):															{"UGV"};
			case ("Van_01_base_F" in _parents || "Van_02_base_F" in _parents):															{"Van"};
			case ("Kart_01_Base_F" in _parents):																						{"Kart"};
			case ("Tractor_01_base_F" in _parents):																						{"Tractor"};
			case ("Quadbike_01_base_F" in _parents):																					{"Quad"};
			case ("Motorcycle" in _parents):																							{"Motorcycle"};
			case ("Truck_F" in _parents):																								{"Truck"};
			case ("Boat_F" in _parents):																								{"Boat"};
			case ("Ship" in _parents):																									{"Ship"};
			case ("Helicopter" in _parents):																							{"Helicopter"};
			case ("Plane" in _parents):																									{"Plane"};
			case ("Tank" in _parents):																									{"Tank"};
			case ("Car" in _parents):																									{"Car"};
			default 																													{"Unknown"};
		};

		_mass = getNumber(configFile >> "CfgMagazines" >> _configName >> "mass");
		_weight = round( ((_mass * 10) / 2.20462262185) * 1000 ); // weight in grams
		_mod = ["CfgVehicles", _configName] call FUNC(getMod);

		_crewSlots = [_configName, false] call BIS_fnc_crewCount;
		_allSlots = [_configName, true] call BIS_fnc_crewCount;
		_cargoSlots = _allSlots - _crewSlots;

		if (_type != "Unknown") then {
			formatText ["%1;%2;%3;%4;%5;%6;%7;%8;%9;%10", _name, _type, _configName, _mod, _mass, _weight, _crewSlots, _cargoSlots] call FUNC(writeToFile);
		}
	};
} foreach _vehicles;


text "--- CONFIG DUMP CSV END ---" call FUNC(writeToFile);
hint ("unitaf_export_vehicle.csv" call FUNC(writeToFile));

["Vehicle Export to CSV Completed", 0] call BIS_fnc_3DENNotification;