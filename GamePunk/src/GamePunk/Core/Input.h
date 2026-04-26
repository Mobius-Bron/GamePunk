#pragma once

#include "GamePunk/Core/KeyCodes.h"
#include "GamePunk/Core/MouseCodes.h"

#include <glm/glm.hpp>

namespace GP 
{
	class Input
	{
	public:
		static bool IsKeyPressed(KeyCode key);

		static bool IsMouseButtonPressed(MouseCode button);
		static glm::vec2 GetMousePosition();
		static float GetMouseX();
		static float GetMouseY();
	};
}
