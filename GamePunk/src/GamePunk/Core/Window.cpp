#include "gppch.h"
#include "GamePunk/Core/Window.h"

#ifdef GP_PLATFORM_WINDOWS
	#include "Platform/Windows/WindowsWindow.h"
#endif

namespace GP
{
	Scope<Window> Window::Create(const WindowProps& props)
	{
#ifdef GP_PLATFORM_WINDOWS
		return CreateScope<WindowsWindow>(props);
#else
		GP_CORE_ASSERT(false, "Unknown platform!");
		return nullptr;
#endif
	}

}