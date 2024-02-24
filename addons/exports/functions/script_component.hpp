#include "\u\unitaf\addons\exports\script_component.hpp"

#define KG_TO_MASS(KG)		__EVAL( round( (KG * 0.1) * (1 * 2.2046) * 100 ) * 100 )
#define MASS_TO_LB(MASS)	__EVAL( round( MASS * 10) )
#define MASS_TO_KG(MASS)	__EVAL( round( (MASS * 10) * 0.45359237  ) )
#define MASS_TO_KG2(MASS)	__EVAL( round( (MASS * 10) / 2.20462262185 ) )