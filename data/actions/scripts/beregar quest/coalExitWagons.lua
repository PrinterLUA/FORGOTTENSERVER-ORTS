local wagons = {
	{actionId = 50122, teleportPos = Position(32704, 31507, 12)}, -- small tunnel with golems 
	{actionId = 50123, teleportPos = Position(32661, 31495, 13)}, -- mushroom quest
	{actionId = 50124, teleportPos = Position(32687, 31470, 13)}, -- wagon maze
	{actionId = 50125, teleportPos = Position(32690, 31495, 11)} -- room with lava that I couldn't find, setting destination to the same as mushroom quest
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	
	for i = 1, #wagons do
		local table = wagons[i]
		if item.actionid == table.actionId then
			player:teleportTo(table.teleportPos, true)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			Item(item.actionid):remove()
		end
	end
	return true
end
