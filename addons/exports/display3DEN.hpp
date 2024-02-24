class ctrlMenuStrip;
class display3DEN
{
	class Controls
	{
		class MenuStrip: ctrlMenuStrip
		{
			class Items
			{
				// Replace with UNITAF item instead of tools?
				class Tools
				{
					items[] += {QGVAR(mainFolder)};
				};
				class GVAR(mainFolder)
				{
					text = "UNITAF Exports";
					items[] = {
					//	QGVAR(composition),
						QGVAR(gearCSV),
						QGVAR(vehicleCSV)
					};
				};
				class GVAR(composition)
				{
					text = "Export composition";
					//picture = "\MyAddon\data\myAwesomeTool_ca.paa"; // Item picture
					action = "[] call ME_fnc_MyAwesomeTool;";// Expression called upon clicking; ideally, it should call your custom function
                    //opensNewWindow = 1; // Adds ... to the name of the menu entry, indicating the user that a new window will be opened.
				};
				class GVAR(gearCSV)
				{
					text = "Export Gear to CSV";
					action = QUOTE(call FUNC(exportGearCSV));
				};
				class GVAR(vehicleCSV)
				{
					text = "Export Vehicles to CSV";
					action = QUOTE(call FUNC(exportVehicleCSV));
				};
			};
		};
	};
};