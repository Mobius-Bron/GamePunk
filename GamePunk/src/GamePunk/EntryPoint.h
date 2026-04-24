#pragma once

#include "Application.h"
#include "stdio.h"

#ifdef  GP_PLATFORM_WINDOWS

extern GP::Application* GP::CreateApplication();

int main(int argc, char** argv)
{
	printf("GamePunk Engine Starting...\n");

	auto app = GP::CreateApplication();

	printf("GamePunk Engine Running...\n");
	app->Run();

	delete app;
}

#endif //  GP_PLATFROM_WINDOWS