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
IncludeDir["stb_image"]   = "GamePunk/vendor/stb_image"
IncludeDir["yaml_cpp"]    = "GamePunk/vendor/yaml-cpp/include"
IncludeDir["Box2D"]       = "GamePunk/vendor/Box2D/include"
IncludeDir["filewatch"]   = "GamePunk/vendor/filewatch"
IncludeDir["GLFW"]        = "GamePunk/vendor/GLFW/include"
IncludeDir["Glad"]        = "GamePunk/vendor/Glad/include"
IncludeDir["ImGui"]       = "GamePunk/vendor/imgui"
IncludeDir["ImGuizmo"]    = "GamePunk/vendor/ImGuizmo"
IncludeDir["glm"]         = "GamePunk/vendor/glm"
IncludeDir["entt"]        = "GamePunk/vendor/entt/include"
IncludeDir["spdlog"]      = "GamePunk/vendor/spdlog/include"
IncludeDir["mono"]        = "GamePunk/vendor/mono/include"
IncludeDir["msdfgen"]     = "GamePunk/vendor/msdf-atlas-gen/msdfgen"
IncludeDir["msdf_atlas_gen"] = "GamePunk/vendor/msdf-atlas-gen/msdf-atlas-gen"

-- Library directories (for precompiled libraries)
LibraryDir = {}
LibraryDir["mono"] = "GamePunk/vendor/mono/lib"

-- Library names
Library = {}
Library["mono"] = "mono-static-sgen"  -- 根据 Mono 版本调整

-- 如果需要 Vulkan（可选）
VULKAN_SDK = os.getenv("VULKAN_SDK")
if VULKAN_SDK then
    IncludeDir["VulkanSDK"] = VULKAN_SDK .. "/Include"
end

-- 全局 UTF-8 编译选项
function setup_utf8()
    buildoptions { "/utf-8" }
end

-- ========================
-- 依赖项目组
-- ========================
group "Dependencies"

-- GLFW
project "GLFW"
    kind "StaticLib"
    language "C"
    location "GamePunk/vendor/GLFW"
    
    setup_utf8()
    
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
    
    setup_utf8()
    
    files {
        "GamePunk/vendor/Glad/src/glad.c",
        "GamePunk/vendor/Glad/include/**.h"
    }
    includedirs { "GamePunk/vendor/Glad/include" }

-- imgui (核心)
project "imgui"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    location "GamePunk/vendor/imgui"
    
    setup_utf8()
    
    files {
        "GamePunk/vendor/imgui/*.cpp",
        "GamePunk/vendor/imgui/*.h"
    }
    includedirs { "GamePunk/vendor/imgui" }

-- ImGuizmo (依赖 imgui)
project "ImGuizmo"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    location "GamePunk/vendor/ImGuizmo"
    
    setup_utf8()
    
    files {
        "GamePunk/vendor/ImGuizmo/*.cpp",
        "GamePunk/vendor/ImGuizmo/*.h"
    }
    includedirs {
        "GamePunk/vendor/ImGuizmo",
        "%{IncludeDir.ImGui}"
    }
    links { "imgui" }

-- yaml-cpp
project "yaml-cpp"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    location "GamePunk/vendor/yaml-cpp"
    
    setup_utf8()
    
    files {
        "GamePunk/vendor/yaml-cpp/src/**.cpp",
        "GamePunk/vendor/yaml-cpp/include/**.h"
    }
    includedirs { "GamePunk/vendor/yaml-cpp/include" }
    defines { "YAML_CPP_STATIC_DEFINE" }

-- Box2D
project "Box2D"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    location "GamePunk/vendor/Box2D"
    
    setup_utf8()
    
    files {
        "GamePunk/vendor/Box2D/src/**.cpp",
        "GamePunk/vendor/Box2D/include/**.h"
    }
    includedirs { "GamePunk/vendor/Box2D/include" }

-- msdf-atlas-gen (包含 msdfgen 和 atlas)
project "msdf-atlas-gen"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    location "GamePunk/vendor/msdf-atlas-gen"
    
    setup_utf8()
    
    files {
        "GamePunk/vendor/msdf-atlas-gen/msdf-atlas-gen/**.cpp",
        "GamePunk/vendor/msdf-atlas-gen/msdf-atlas-gen/**.h",
        "GamePunk/vendor/msdf-atlas-gen/msdfgen/**.cpp",
        "GamePunk/vendor/msdf-atlas-gen/msdfgen/**.h"
    }
    includedirs {
        "GamePunk/vendor/msdf-atlas-gen/msdf-atlas-gen",
        "GamePunk/vendor/msdf-atlas-gen/msdfgen"
    }
    defines { "MSDF_ATLAS_USE_SKIA=0" }

group ""

-- ========================
-- 核心项目 GamePunk
-- ========================
group "Core"

project "GamePunk"
    location "GamePunk"
    kind "SharedLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- 预编译头配置
    pchheader "gppch.h"
    pchsource "GamePunk/src/gppch.cpp"

    -- UTF-8 支持
    setup_utf8()

    files {
        "GamePunk/src/**.h",
        "GamePunk/src/**.hpp",
        "GamePunk/src/**.cpp",
        "GamePunk/src/**.c"
    }

    includedirs {
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.ImGuizmo}",
        "%{IncludeDir.yaml_cpp}",
        "%{IncludeDir.Box2D}",
        "%{IncludeDir.filewatch}",
        "%{IncludeDir.entt}",
        "%{IncludeDir.stb_image}",
        "%{IncludeDir.msdfgen}",
        "%{IncludeDir.msdf_atlas_gen}",
        "%{IncludeDir.mono}",
        "GamePunk/src"
    }

    -- 添加库路径
    libdirs {
        "%{LibraryDir.mono}"
    }

    links {
        "GLFW",
        "Glad",
        "imgui",
        "ImGuizmo",
        "yaml-cpp",
        "Box2D",
        "msdf-atlas-gen",
        "opengl32.lib",
        "winmm.lib"
    }

    -- 根据配置链接不同的 Mono 库
    filter "configurations:Debug"
        defines { 
            "GP_DEBUG",
            "_DEBUG"
        }
        runtime "Debug"
        symbols "on"
        links {
            "%{LibraryDir.mono}/Debug/%{Library.mono}.lib"
        }

    filter "configurations:Release or Dist"
        defines { 
            "GP_RELEASE",
            "NDEBUG"
        }
        runtime "Release"
        optimize "on"
        links {
            "%{LibraryDir.mono}/Release/%{Library.mono}.lib"
        }

    filter "system:windows"
        systemversion "latest"
        defines {
            "GP_PLATFORM_WINDOWS",
            "GP_BUILD_DLL"
        }
        postbuildcommands {
            ("{COPY} \"%{cfg.buildtarget.relpath}\" \"../bin/" .. outputdir .. "/Sandbox\"")
        }

group ""

-- ========================
-- 示例项目 Sandbox
-- ========================
group "Misc"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- UTF-8 支持
    setup_utf8()

    files {
        "Sandbox/src/**.h",
        "Sandbox/src/**.hpp",
        "Sandbox/src/**.cpp"
    }

    includedirs {
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.yaml_cpp}",
        "%{IncludeDir.Box2D}",
        "GamePunk/src"
    }

    links { "GamePunk" }

    filter "system:windows"
        systemversion "latest"
        defines { "GP_PLATFORM_WINDOWS" }

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