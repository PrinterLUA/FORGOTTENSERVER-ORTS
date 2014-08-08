function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end

	if player:getStorageValue(1060) >= 32 then
		player:teleportTo(Position(33027, 31084, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
