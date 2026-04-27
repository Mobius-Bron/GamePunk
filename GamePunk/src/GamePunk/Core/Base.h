#pragma once

#include "GamePunk/Core/PlatformDetection.h"

#include <memory>

#ifdef GP_DEBUG
	#if defined(GP_PLATFORM_WINDOWS)
		#define GP_DEBUGBREAK() __debugbreak()
	#elif defined(GP_PLATFORM_LINUX)
		#include <signal.h>
		#define GP_DEBUGBREAK() raise(SIGTRAP)
	#else
		#error "Platform doesn't support debugbreak yet!"
	#endif
	#define GP_ENABLE_ASSERTS
#else
	#define GP_DEBUGBREAK()
#endif

#define GP_EXPAND_MACRO(x) x
#define GP_STRINGIFY_MACRO(x) #x
#define BIT(x) (1 << x)

#define GP_BIND_EVENT_FN(fn) [this](auto&&... args) -> decltype(auto) { return this->fn(std::forward<decltype(args)>(args)...); }

namespace GP
{
	template<typename T>
	using Scope = std::unique_ptr<T>;
	template<typename T, typename ... Args>
	constexpr Scope<T> CreateScope(Args&& ... args)
	{
		return std::make_unique<T>(std::forward<Args>(args)...);
	}

	template<typename T>
	using Ref = std::shared_ptr<T>;
	template<typename T, typename ... Args>
	constexpr Ref<T> CreateRef(Args&& ... args)
	{
		return std::make_shared<T>(std::forward<Args>(args)...);
	}

}

#include "GamePunk/Core/Log.h"
#include "GamePunk/Core/Assert.h"