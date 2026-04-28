#pragma once

#include "GamePunk/Core/Buffer.h"

namespace GP
{
	class FileSystem
	{
	public:
		// TODO: move to FileSystem class
		static Buffer ReadFileBinary(const std::filesystem::path& filepath);
	};

}
