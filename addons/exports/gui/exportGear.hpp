#include "base.hpp"

#define DIALOG_W 180
#define DIALOG_H 100

class GVAR(exportGearUI)
{
	idd = IDC_exportGearUI;
	access = 0;
	movingEnable = true;
	//onLoad = QUOTE(_this call FUNC(tabletOnLoad));
	//onUnload = QUOTE(call FUNC(tabletOnUnload));

	class ControlsBackground {
		DISABLE_BACKGROUND
		class Header: ctrlStaticTitle
		{
			text = "Export Gear to CSV";
			x = CENTERED_X(DIALOG_W);
			y = DIALOG_TOP;
			w = DIALOG_W * GRID_W;
			h = CTRL_DEFAULT_H;
		};
		class Background: ctrlStaticBackground
		{
			x = CENTERED_X(DIALOG_W);
			y = DIALOG_TOP + CTRL_DEFAULT_H;
			w = DIALOG_W * GRID_W;
			h = DIALOG_H * GRID_H;
		};
		class BackgroundButtons: ctrlStaticFooter
		{
			x = CENTERED_X(DIALOG_W);
			y = DIALOG_TOP + 80 * GRID_H;
			w = 110 * GRID_W;
			h = CTRL_DEFAULT_H + 2 * GRID_H;
		};
	};

	class Controls
	{};
};