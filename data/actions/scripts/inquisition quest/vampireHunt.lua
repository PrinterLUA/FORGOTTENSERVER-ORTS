local altars = {
	Position(32777, 31982, 9),
	Position(32779, 31977, 9),
	Position(32781, 31982, 9)
}

function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheInquisition.Questline) == 8 then
		player:setStorageValue(Storage.TheInquisition.Questline, 9)
		player:setStorageValue(Storage.TheInquisition.Mission03, 4) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
		local k = {}
		for _, v in ipairs(altars) do
			local tmp = Tile(v):getItemById(2199)
			if not tmp then
				Game.createMonster("The Count", toPosition)
				return true
			else
				table.insert(k, tmp)
			end
		end
		for i = 1, #k do
			k[i]:remove()
		end
		Game.createMonster("The Weakened Count", toPosition)
		return true
	end
end