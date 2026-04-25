#pragma once

#include "gppch.h"
#include "GamePunk/Core.h"

// spdlog start
// 基础功能
#include <spdlog/spdlog.h>
// 彩色控制台
#include <spdlog/sinks/stdout_color_sinks.h>
// 文件日志
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/rotating_file_sink.h>
// 异步日志
#include <spdlog/async.h>
// spdlog end

namespace GP
{
	class GAMEPUNK_API Log
	{
	public:
		Log();
		~Log();

		static void Init();

		inline static std::shared_ptr<spdlog::logger>& GetCoreLogger() { return s_CoreLogger; }
		inline static std::shared_ptr<spdlog::logger>& GetClientLogger() { return s_ClientLogger; }

	private:
		static std::shared_ptr<spdlog::logger> s_CoreLogger;
		static std::shared_ptr<spdlog::logger> s_ClientLogger;
	};
}

// Core log macros
#define GP_CORE_TRACE(...)		::GP::Log::GetCoreLogger()->trace(__VA_ARGS__)
#define GP_CORE_INFO(...)		::GP::Log::GetCoreLogger()->info(__VA_ARGS__)
#define GP_CORE_WARN(...)		::GP::Log::GetCoreLogger()->warn(__VA_ARGS__)
#define GP_CORE_ERROR(...)		::GP::Log::GetCoreLogger()->error(__VA_ARGS__)
#define GP_CORE_CRITICAL(...)	::GP::Log::GetCoreLogger()->critical(__VA_ARGS__)
#define GP_CORE_FATAL(...)		::GP::Log::GetCoreLogger()->fatal(__VA_ARGS__)

// Client log macros
#define GP_TRACE(...)			::GP::Log::GetClientLogger()->trace(__VA_ARGS__)
#define GP_INFO(...)			::GP::Log::GetClientLogger()->info(__VA_ARGS__)
#define GP_WARN(...)			::GP::Log::GetClientLogger()->warn(__VA_ARGS__)
#define GP_ERROR(...)			::GP::Log::GetClientLogger()->error(__VA_ARGS__)
#define GP_CRITICAL(...)		::GP::Log::GetClientLogger()->critical(__VA_ARGS__)
#define GP_FATAL(...)			::GP::Log::GetClientLogger()->fatal(__VA_ARGS__)
