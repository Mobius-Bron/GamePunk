#pragma once

#include "gppch.h"
#include "Application.h"
#include "GamePunk/Core/Log.h"

#ifdef  GP_PLATFORM_WINDOWS

extern GP::Application* GP::CreateApplication();

int main(int argc, char** argv)
{
	GP::Log::Init();

	//GP_PROFILE_BEGIN_SESSION("Startup", "GamePunkProfile-Startup.json");
	auto app = GP::CreateApplication();
	//GP_PROFILE_END_SESSION();

	//GP_PROFILE_BEGIN_SESSION("Startup", "GamePunkProfile-Startup.json");
	app->Run();
	//GP_PROFILE_END_SESSION();

	//GP_PROFILE_BEGIN_SESSION("Startup", "GamePunkProfile-Startup.json");
	delete app;
	//GP_PROFILE_END_SESSION();
}

#endif //  GP_PLATFROM_WINDOWS