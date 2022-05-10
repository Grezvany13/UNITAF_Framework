class Van_02_base_F;
class Van_02_vehicle_base_F: Van_02_base_F {
	class TextureSources {
		class UNITAFBlack {
			displayName = "[UNITAF] Black";
			author = "UNITAF";
			textures[] = {"\u\unitaf\addons\reskin\assets\vehicles\training\van.paa","\a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa","\a3\soft_f_orange\van_02\data\van_glass_transport_CA.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"};
			materials[] = {"\a3\Soft_F_Orange\Van_02\Data\van_body.rvmat","\A3\Soft_F_Orange\Van_02\Data\van_wheel_transport.rvmat","","\a3\Data_f\Lights\Car_Beacon_Orange_emit.rvmat"};
			factions[] = {"Faction_UNITAF"};
		};
		class UNITAFKhaki {
			displayName = "[UNITAF] Khaki";
			author = "UNITAF";
			textures[] = {"\u\unitaf\addons\reskin\assets\vehicles\training\van-khaki4.paa","\a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa","\a3\soft_f_orange\van_02\data\van_glass_transport_CA.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"};
			materials[] = {"\a3\Soft_F_Orange\Van_02\Data\van_body.rvmat","\A3\Soft_F_Orange\Van_02\Data\van_wheel_transport.rvmat","","\a3\Data_f\Lights\Car_Beacon_Orange_emit.rvmat"};
			factions[] = {"Faction_UNITAF"};
		};
	};
	dlc = QUOTE(PREFIX);
};

class GVAR(Training_Van_Black): Van_02_vehicle_base_F {
	side = 1;
	scope = 2;
	scopeCurator = 2;
	crew = "B_GEN_Soldier_F";
	typicalCargo[] = {"B_GEN_Soldier_F"};
	faction = "Faction_UNITAF";
	editorSubcategory = "EdSubcat_UNITAF_Training";
	displayName = "[UNITAF] Van Training Transport (Black)";
	author = "UNITAF";
	hiddenSelections[] = {"camo1", "camo2", "camo3", "emergency_lights"};
	hiddenSelectionsTextures[] = {"\u\unitaf\addons\reskin\assets\vehicles\training\van.paa","\a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa","\a3\soft_f_orange\van_02\data\van_glass_transport_CA.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"};
	hiddenSelectionMaterials[] = {"\a3\Soft_F_Orange\Van_02\Data\van_body.rvmat","\A3\Soft_F_Orange\Van_02\Data\van_wheel_transport.rvmat","","\a3\Data_f\Lights\Car_Beacon_Orange_emit.rvmat"};
	textureList[] = { "UNITAFBlack", 1 };
	animationList[] = {
		"beacon_front_hide", 1,
		"beacon_rear_hide", 1,
		"LED_lights_hide", 1,
		"reflective_tape_hide", 1,
		"side_protective_frame_hide", 0,
		"front_protective_frame_hide", 0,
		"ladder_hide", 1,
		"spare_tyre_holder_hide", 1,
		"spare_tyre_hide", 1,
		"roof_rack_hide", 1,
		"sidesteps_hide", 1,
		"rearsteps_hide", 1
	};
	dlc = QUOTE(PREFIX);
};
class GVAR(Training_Van_Khaki): Van_02_vehicle_base_F {
	side = 1;
	scope = 2;
	scopeCurator = 2;
	crew = "B_GEN_Soldier_F";
	typicalCargo[] = {"B_GEN_Soldier_F"};
	faction = "Faction_UNITAF";
	editorSubcategory = "EdSubcat_UNITAF_Training";
	displayName = "[UNITAF] Van Training Transport (Khaki)";
	author = "UNITAF";
	hiddenSelections[] = {"camo1", "camo2", "camo3", "emergency_lights"};
	hiddenSelectionsTextures[] = {"\u\unitaf\addons\reskin\assets\vehicles\training\van-khaki4.paa","\a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa","\a3\soft_f_orange\van_02\data\van_glass_transport_CA.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_Black_CO.paa"};
	hiddenSelectionMaterials[] = {"\a3\Soft_F_Orange\Van_02\Data\van_body.rvmat","\A3\Soft_F_Orange\Van_02\Data\van_wheel_transport.rvmat","","\a3\Data_f\Lights\Car_Beacon_Orange_emit.rvmat"};
	textureList[] = { "UNITAFKhaki", 1 };
	animationList[] = {
		"beacon_front_hide", 1,
		"beacon_rear_hide", 1,
		"LED_lights_hide", 1,
		"reflective_tape_hide", 1,
		"side_protective_frame_hide", 0,
		"front_protective_frame_hide", 0,
		"ladder_hide", 1,
		"spare_tyre_holder_hide", 1,
		"spare_tyre_hide", 1,
		"roof_rack_hide", 1,
		"sidesteps_hide", 1,
		"rearsteps_hide", 1
	};
	dlc = QUOTE(PREFIX);
};

class Offroad_01_military_covered_base_F;

class GVAR(Training_Offroad_Black): Offroad_01_military_covered_base_F {
	side = 1;
	scope = 2;
	scopeCurator = 2;
	crew = "B_GEN_Soldier_F";
	typicalCargo[] = {"B_GEN_Soldier_F"};
	faction = "Faction_UNITAF";
	editorSubcategory = "EdSubcat_UNITAF_Training";
	displayName = "[UNITAF] Offroad Instructor (black)";
	author = "UNITAF";
	hiddenSelections[] = {"Camo", "Camo2", "Camo3"};
	hiddenSelectionsTextures[] = {"\u\unitaf\addons\reskin\assets\vehicles\training\offroad.paa","\u\unitaf\addons\reskin\assets\vehicles\training\offroad.paa"};
	animationList[] = {
		"hidePolice", 1,
		"HideServices", 1,
		"HideConstruction", 1,
		"HideCover", 1,
		"HideRoofRack", 1,
		"HideLoudSpeakers", 1,
		"HideAntennas", 1,
		"HideBeacon", 1,
		"HideSpotlight", 1,
		"HideCoverTailGate", 1,
		"HideDoor3", 1,
		"HideBumper1", 1,
		"HideBumper2", 0
	};
	dlc = QUOTE(PREFIX);
};
class GVAR(Training_Offroad_Khaki): Offroad_01_military_covered_base_F {
	side = 1;
	scope = 2;
	scopeCurator = 2;
	crew = "B_GEN_Soldier_F";
	typicalCargo[] = {"B_GEN_Soldier_F"};
	faction = "Faction_UNITAF";
	editorSubcategory = "EdSubcat_UNITAF_Training";
	displayName = "[UNITAF] Offroad Instructor (Khaki)";
	author = "UNITAF";
	hiddenSelections[] = {"Camo", "Camo2", "Camo3"};
	hiddenSelectionsTextures[] = {"\u\unitaf\addons\reskin\assets\vehicles\training\offroad-khaki4.paa","\u\unitaf\addons\reskin\assets\vehicles\training\offroad-khaki4.paa"};
	animationList[] = {
		"hidePolice", 1,
		"HideServices", 1,
		"HideConstruction", 1,
		"HideCover", 1,
		"HideRoofRack", 1,
		"HideLoudSpeakers", 1,
		"HideAntennas", 1,
		"HideBeacon", 1,
		"HideSpotlight", 1,
		"HideCoverTailGate", 1,
		"HideDoor3", 1,
		"HideBumper1", 1,
		"HideBumper2", 0
	};
	dlc = QUOTE(PREFIX);
};

class GVAR(Training_Offroad_KhakiCI): Offroad_01_military_covered_base_F {
	side = 1;
	scope = 2;
	scopeCurator = 2;
	crew = "B_GEN_Soldier_F";
	typicalCargo[] = {"B_GEN_Soldier_F"};
	faction = "Faction_UNITAF";
	editorSubcategory = "EdSubcat_UNITAF_Training";
	displayName = "[UNITAF] Offroad Chief Instructor (Khaki)";
	author = "UNITAF";
	hiddenSelections[] = {"Camo", "Camo2", "Camo3"};
	hiddenSelectionsTextures[] = {"\u\unitaf\addons\reskin\assets\vehicles\training\offroad-khaki4CI.paa","\u\unitaf\addons\reskin\assets\vehicles\training\offroad-khaki4CI.paa"};
	animationList[] = {
		"hidePolice", 1,
		"HideServices", 1,
		"HideConstruction", 1,
		"HideCover", 1,
		"HideRoofRack", 1,
		"HideLoudSpeakers", 1,
		"HideAntennas", 1,
		"HideBeacon", 0,
		"HideSpotlight", 1,
		"HideCoverTailGate", 1,
		"HideDoor3", 1,
		"HideBumper1", 1,
		"HideBumper2", 0
	};
	dlc = QUOTE(PREFIX);
};

class Plane_Civil_01_base_F;
class GVAR(Training_Cessna): Plane_Civil_01_base_F {
	side = 1;
	scope = 2;
	scopeCurator = 2;
	faction = "Faction_UNITAF";
	editorSubcategory = "EdSubcat_UNITAF_Training";
	displayName = "[UNITAF] Training Cessna TTx";
	author = "UNITAF";
	crew = "B_GEN_Soldier_F";
	typicalCargo[] = {
		"B_GEN_Soldier_F"
	};
	hiddenSelections[] = {
		"camo1",
		"camo2",
		"camo3",
		"camo4"
	};
	hiddenSelectionsTextures[] = {
		"\u\unitaf\addons\reskin\assets\vehicles\training\unitaf_training_plane_body.paa",
		"\u\unitaf\addons\reskin\assets\vehicles\training\unitaf_training_plane_wings.paa",
		"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_01_co.paa",
		"A3\Air_F_Exp\Plane_Civil_01\Data\btt_int_02_co.paa"
	};
	dlc = QUOTE(PREFIX);
	class EventHandlers {
		init="if (local (_this select 0)) then {[(_this select 0), nil, nil] call bis_fnc_initVehicle;};";
	};
};