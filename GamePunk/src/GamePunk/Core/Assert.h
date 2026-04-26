#pragma once

#include "GamePunk/Core/Base.h"
#include "GamePunk/Core/Log.h"
#include <filesystem>

#ifdef GP_ENABLE_ASSERTS

	// Alteratively we could use the same "default" message for both "WITH_MSG" and "NO_MSG" and
	// provide support for custom formatting by concatenating the formatting string instead of having the format inside the default message
	#define GP_INTERNAL_ASSERT_IMPL(type, check, msg, ...) { if(!(check)) { GP##type##ERROR(msg, __VA_ARGS__); GP_DEBUGBREAK(); } }
	#define GP_INTERNAL_ASSERT_WITH_MSG(type, check, ...) GP_INTERNAL_ASSERT_IMPL(type, check, "Assertion failed: {0}", __VA_ARGS__)
	#define GP_INTERNAL_ASSERT_NO_MSG(type, check) GP_INTERNAL_ASSERT_IMPL(type, check, "Assertion '{0}' failed at {1}:{2}", GP_STRINGIFY_MACRO(check), std::filesystem::path(__FILE__).filename().string(), __LINE__)

	#define GP_INTERNAL_ASSERT_GET_MACRO_NAME(arg1, arg2, macro, ...) macro
	#define GP_INTERNAL_ASSERT_GET_MACRO(...) GP_EXPAND_MACRO( GP_INTERNAL_ASSERT_GET_MACRO_NAME(__VA_ARGS__, GP_INTERNAL_ASSERT_WITH_MSG, GP_INTERNAL_ASSERT_NO_MSG) )

	// Currently accepts at least the condition and one additional parameter (the message) being optional
	#define GP_ASSERT(...) GP_EXPAND_MACRO( GP_INTERNAL_ASSERT_GET_MACRO(__VA_ARGS__)(_, __VA_ARGS__) )
	#define GP_CORE_ASSERT(...) GP_EXPAND_MACRO( GP_INTERNAL_ASSERT_GET_MACRO(__VA_ARGS__)(_CORE_, __VA_ARGS__) )
#else
	#define GP_ASSERT(...)
	#define GP_CORE_ASSERT(...)
#endif
