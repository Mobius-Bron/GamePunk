#include "gppch.h"
#include "Platform/OpenGL/OpenGLContext.h"

#include <GLFW/glfw3.h>
#include <glad/glad.h>

namespace GP 
{

	OpenGLContext::OpenGLContext(GLFWwindow* windowHandle)
		: m_WindowHandle(windowHandle)
	{
		GP_CORE_ASSERT(windowHandle, "Window handle is null!")
	}

	void OpenGLContext::Init()
	{
		GP_PROFILE_FUNCTION();

		glfwMakeContextCurrent(m_WindowHandle);
		int status = gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
		GP_CORE_ASSERT(status, "Failed to initialize Glad!");
		GP_CORE_INFO("OpenGL Info:");
		GP_CORE_INFO("  Vendor: {0}", glGetString(GL_VENDOR));
		GP_CORE_INFO("  Renderer: {0}", glGetString(GL_RENDERER));
		GP_CORE_INFO("  Version: {0}", glGetString(GL_VERSION));	
		GP_CORE_ASSERT(GLVersion.major > 4 || (GLVersion.major == 4 && GLVersion.minor >= 5), "GamePunk requires at least OpenGL version 4.5!");
	}

	void OpenGLContext::SwapBuffers()
	{
		GP_PROFILE_FUNCTION();

		glfwSwapBuffers(m_WindowHandle);
	}

}
