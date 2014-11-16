local wall = {
	Position(33295, 31677, 15),
	Position(33296, 31677, 15),
	Position(33297, 31677, 15),
	Position(33298, 31677, 15),
	Position(33299, 31677, 15)
}

function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if item.itemid == 1946 then
		return false
	end

	local thing
	for i = 1, #wall do
		thing = Tile(wall[i]):getItemById(1304)
		if thing then
			thing:remove()
		end
	end

	Item(item.uid):transform(1946)
	return true
end