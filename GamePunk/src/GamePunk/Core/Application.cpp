#include "gppch.h"
#include "Application.h"

#include "GamePunk/Events/ApplicationEvent.h"
#include "GamePunk/Core/Log.h"

namespace GP
{
	Application::Application()
	{
	}
	Application::~Application()
	{
	}
	void Application::Run()
	{
		GP::WindowResizeEvent event(1440, 810);
		if(event.IsInCategory(GP::EventCategoryApplication))
		{
			GP_TRACE("EventCategoryApplication {0}", event.ToString());
		}
		if(event.IsInCategory(GP::EventCategoryInput))
		{
			GP_TRACE("EventCategoryInput {0}", event.ToString());
		}

		while (true)
		{
			// Handle the event
		}
	}

	Application* CreateApplication()
	{
		return new Application();
	}
}