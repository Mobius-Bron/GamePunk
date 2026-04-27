#include "gppch.h"
#include "GamePunk/Renderer/VertexArray.h"

#include "GamePunk/Renderer/Renderer.h"
#include "Platform/OpenGL/OpenGLVertexArray.h"

namespace GP
{
	Ref<VertexArray> VertexArray::Create()
	{
		switch (Renderer::GetAPI())
		{
		case RendererAPI::API::None:    GP_CORE_ASSERT(false, "RendererAPI::None is currently not supported!"); return nullptr;
		case RendererAPI::API::OpenGL:  return CreateRef<OpenGLVertexArray>();
		}

		GP_CORE_ASSERT(false, "Unknown RendererAPI!");
		return nullptr;
	}

}
