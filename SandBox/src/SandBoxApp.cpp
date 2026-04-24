#include <GamePunk.h>

class SandBox : public GP::Application
{
public:
	SandBox()
	{
	}
	~SandBox()
	{
	}
};

GP::Application* GP::CreateApplication()
{
	return new SandBox();
}