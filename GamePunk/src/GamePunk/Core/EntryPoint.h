#pragma once

#include "gppch.h"
#include "Application.h"
#include "GamePunk/Core/Log.h"

#ifdef  GP_PLATFORM_WINDOWS

extern GP::Application* GP::CreateApplication();

int main(int argc, char** argv)
{
	printf("GamePunk Engine Starting...\n");

	GP::Log::Init();
	GP_CORE_WARN("Core Initialized Log!");

	auto app = GP::CreateApplication();

	app->Run();

	delete app;
}

#endif //  GP_PLATFROM_WINDOWS