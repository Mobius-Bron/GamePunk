#pragma once

#include "gppch.h"
#include "Application.h"
#include "GamePunk/Core/Log.h"

#ifdef  GP_PLATFORM_WINDOWS

//extern GP::Application* GP::CreateApplication();
namespace GP {

	class GPlnut : public Application
	{
	public:
		GPlnut(const ApplicationSpecification& spec)
			: Application(spec)
		{
			//PushLayer(new EditorLayer());
		}
	};

	Application* CreateApplication(ApplicationCommandLineArgs args)
	{
		ApplicationSpecification spec;
		spec.Name = "Hazelnut";
		spec.CommandLineArgs = args;

		return new GPlnut(spec);
	}

}

int main(int argc, char** argv)
{
	GP::Log::Init();

	//GP_PROFILE_BEGIN_SESSION("Startup", "GamePunkProfile-Startup.json");
	auto app = GP::CreateApplication({ argc, argv });
	//GP_PROFILE_END_SESSION();

	//GP_PROFILE_BEGIN_SESSION("Startup", "GamePunkProfile-Startup.json");
	app->Run();
	//GP_PROFILE_END_SESSION();

	//GP_PROFILE_BEGIN_SESSION("Startup", "GamePunkProfile-Startup.json");
	delete app;
	//GP_PROFILE_END_SESSION();
}

#endif //  GP_PLATFROM_WINDOWS