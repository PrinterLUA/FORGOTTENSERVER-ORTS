local demonPos = {
	{x=33060, y=31623, z=15},
	{x=33066, y=31623, z=15},
	{x=33060, y=31627, z=15},
	{x=33066, y=31627, z=15}
}

function onRemoveItem(item, tile, position)
local targetItem = Item(item.actionid)
	if(item.itemid == 1953 and targetItem == 60999) and targetItem:getPosition():getDistance(position) > 0 then
		targetItem:setActionId(0) --any better solution?
		for i = 1, #demonPos do
			Game.createMonster("Demon", demonPos[i])
		end
	end
	return true
end
