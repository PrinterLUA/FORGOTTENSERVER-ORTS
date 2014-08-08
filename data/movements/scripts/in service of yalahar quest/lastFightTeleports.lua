function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end

	if item.uid == 7809 then
		if player:getStorageValue(Storage.InServiceofYalahar.Questline) == 51 then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(32783, 31174, 10))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:say('The apparatus in the centre looks odd! You should inspect it.', TALKTYPE_MONSTER_SAY)
		else
			player:teleportTo(fromPosition)
		end

	elseif item.uid == 7810 then
		if getGlobalStorageValue(982) < 1 then
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(Position(32784, 31178, 9))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		else
			player:teleportTo(fromPosition)
		end
	end
	return true
end
