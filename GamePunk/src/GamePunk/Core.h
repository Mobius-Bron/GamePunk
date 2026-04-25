#pragma once

#include "GamePunk/Core/Base.h" 

#ifdef  GP_PLATFORM_WINDOWS
	#ifdef GP_BUILD_DLL
		#define GAMEPUNK_API __declspec(dllexport)
	#else
		#define GAMEPUNK_API __declspec(dllimport)
	#endif // GP_BUILD_DLL

#else
	#error GamePunk only supports Windows!

#endif //  GP_PLATFROM_WINDOWS
