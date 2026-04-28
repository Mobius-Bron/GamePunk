#pragma once

#include "GamePunk/Core/Layer.h"

#include "GamePunk/Events/ApplicationEvent.h"
#include "GamePunk/Events/KeyEvent.h"
#include "GamePunk/Events/MouseEvent.h"

namespace GP
{
	class ImGuiLayer : public Layer
	{
	public:
		ImGuiLayer();
		~ImGuiLayer() = default;

		virtual void OnAttach() override;
		virtual void OnDetach() override;
		virtual void OnEvent(Event& e) override;

		void Begin();
		void End();

		void BlockEvents(bool block) { m_BlockEvents = block; }

		void SetDarkThemeColors();

		uint32_t GetActiveWidgetID() const;
	private:
		bool m_BlockEvents = true;
	};

}
