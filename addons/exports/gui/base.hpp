#include "\a3\ui_f\hpp\defineCommonGrids.inc"

class ctrlStaticTitle;
class ctrlStaticBackground;
class ctrlStaticFooter;

#define CENTERED_X(w) (CENTER_X - (w / 2 * GRID_W))
#define DIALOG_TOP (safezoneY + 17 * GRID_H)
#define CTRL_DEFAULT_H (SIZE_M * GRID_H)


// IDC's
// UNITAF = 85 + 78 + 73 + 84 + 65 + 70 = 455 =  455000

// Tablet already uses some prefixes:
// 		Base 4550xx
//		Welcome 4551xx
// 		Main 4553xx
// 		Admin 4554xx
// 		OPORD 4555xx
// 		ORBAT 4556xx
// 		LOGISTICS 4557xx

