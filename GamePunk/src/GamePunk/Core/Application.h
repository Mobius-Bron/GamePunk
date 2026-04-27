#pragma once

#include "Core.h"

namespace GP
{

	class GAMEPUNK_API Application
	{
		public:

		Application();

		virtual ~Application();

		void Run();
	};

	// To be defined in client
	Application* CreateApplication();
}


