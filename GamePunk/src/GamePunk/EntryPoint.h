#pragma once

#include "Application.h"
#include "Log.h"
#include "stdio.h"

#ifdef  GP_PLATFORM_WINDOWS

extern GP::Application* GP::CreateApplication();

int main(int argc, char** argv)
{
	printf("GamePunk Engine Starting...\n");

	GP::Log::Init();
	GP_CORE_WARN("Core Initialized Log!");

	int a = 5;
	GP_INFO("Var = {0}", a);

	auto app = GP::CreateApplication();
	printf("Application Created...\n");

	app->Run();

	delete app;
}

#endif //  GP_PLATFROM_WINDOWS