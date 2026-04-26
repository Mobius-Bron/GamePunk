workspace "GamePunk"
    architecture "x64"
    startproject "GamePunk"
    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories
IncludeDir = {}
IncludeDir["GLFW"] = "GamePunk/vendor/GLFW/include"
IncludeDir["Glad"] = "GamePunk/vendor/Glad/include"
IncludeDir["glm"] = "GamePunk/vendor/glm"
IncludeDir["imgui"] = "GamePunk/vendor/imgui"
IncludeDir["spdlog"] = "GamePunk/vendor/spdlog/include"

-- Dependencies group
group "Dependencies"

-- GLFW
project "GLFW"
    kind "StaticLib"
    language "C"
    location "GamePunk/vendor/GLFW"
    files { 
        "GamePunk/vendor/GLFW/src/win32_*.c",
        "GamePunk/vendor/GLFW/src/wgl_*.c",
        "GamePunk/vendor/GLFW/src/egl_*.c",
        "GamePunk/vendor/GLFW/src/context.c",
        "GamePunk/vendor/GLFW/src/init.c",
        "GamePunk/vendor/GLFW/src/input.c",
        "GamePunk/vendor/GLFW/src/monitor.c",
        "GamePunk/vendor/GLFW/src/platform.c",
        "GamePunk/vendor/GLFW/src/vulkan.c",
        "GamePunk/vendor/GLFW/src/window.c",
        "GamePunk/vendor/GLFW/include/**.h"
    }
    includedirs { 
        "GamePunk/vendor/GLFW/include",
        "GamePunk/vendor/GLFW/src"
    }
    defines { 
        "_GLFW_WIN32",
        "_CRT_SECURE_NO_WARNINGS"
    }
    filter "system:windows"
        defines { "_GLFW_WIN32" }

-- Glad
project "Glad"
    kind "StaticLib"
    language "C"
    location "GamePunk/vendor/Glad"
    files { 
        "GamePunk/vendor/Glad/src/glad.c",
        "GamePunk/vendor/Glad/include/**.h"
    }
    includedirs { "GamePunk/vendor/Glad/include" }

-- glm (header only)
project "glm"
    kind "StaticLib"
    language "C++"
    location "GamePunk/vendor/glm"
    files { 
        "GamePunk/vendor/glm/glm/**.h",
        "GamePunk/vendor/glm/glm/**.hpp"
    }
    includedirs { "GamePunk/vendor/glm" }

-- imgui
project "imgui"
    kind "StaticLib"
    language "C++"
    location "GamePunk/vendor/imgui"
    files { 
        "GamePunk/vendor/imgui/*.cpp",
        "GamePunk/vendor/imgui/*.h"
    }
    includedirs { "GamePunk/vendor/imgui" }

-- spdlog (header only)
project "spdlog"
    kind "StaticLib"
    language "C++"
    location "GamePunk/vendor/spdlog"
    files { 
        "GamePunk/vendor/spdlog/include/**.h",
        "GamePunk/vendor/spdlog/include/**.hpp"
    }
    includedirs { "GamePunk/vendor/spdlog/include" }

group ""

-- Core project
group "Core"

project "GamePunk"
    location "GamePunk"
    kind "SharedLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "gppch.h"
    pchsource "GamePunk/src/gppch.cpp"

    files
    {
        "GamePunk/src/**.h",
        "GamePunk/src/**.hpp",
        "GamePunk/src/**.cpp"
    }

    includedirs
    {
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.imgui}",
        "GamePunk/src"
    }

    links
    {
        "GLFW",
        "Glad",
        "glm",
        "imgui",
        "spdlog",
        "opengl32.lib"
    }

    filter "system:windows"
        systemversion "latest"
        defines
        {
            "GP_PLATFORM_WINDOWS",
            "GP_BUILD_DLL"
        }
        postbuildcommands
        {
            ("{COPY} \"%{cfg.buildtarget.relpath}\" \"../bin/" .. outputdir .. "/Sandbox\"")
        }

    filter "configurations:Debug"
        defines "GP_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "GP_RELEASE"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "GP_DIST"
        runtime "Release"
        optimize "on"

group ""

-- Misc project
group "Misc"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "Sandbox/src/**.h",
        "Sandbox/src/**.hpp",
        "Sandbox/src/**.cpp"
    }

    includedirs
    {
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.imgui}",
        "GamePunk/src"
    }

    links
    {
        "GamePunk"
    }

    filter "system:windows"
        systemversion "latest"
        defines
        {
            "GP_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "GP_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "GP_RELEASE"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "GP_DIST"
        runtime "Release"
        optimize "on"

group ""