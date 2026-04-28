#include "gppch.h"
#include "Entity.h"

namespace GP
{
	Entity::Entity(entt::entity handle, Scene* scene)
		: m_EntityHandle(handle), m_Scene(scene)
	{
	}

}
