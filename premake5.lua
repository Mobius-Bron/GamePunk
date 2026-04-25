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

project "GamePunk"
    location "GamePunk"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "gppch.h"
    pchsource "%{prj.name}/src/gppch.cpp"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{prj.name}/vendor/spdlog/include",
        "%{prj.name}/src"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"
        buildoptions { "/utf-8" }  -- 添加 /utf-8 编译选项
        defines
        {
            "GP_PLATFORM_WINDOWS",
            "GP_BUILD_DLL"
        }
        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }

    filter "configurations:Debug"
        defines "GP_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "GP_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "GP_DIST"
        optimize "On" 

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }
    includedirs
    {
        "GamePunk/vendor/spdlog/include",
        "GamePunk/src"
    }
    links
    {
        "GamePunk"
    }
    
    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"
        buildoptions { "/utf-8" }  -- 添加 /utf-8 编译选项
        defines
        {
            "GP_PLATFORM_WINDOWS",
        }

    filter "configurations:Debug"
        defines "GP_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "GP_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "GP_DIST"
        optimize "On"