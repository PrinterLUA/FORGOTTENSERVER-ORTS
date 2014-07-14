function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end

	local pitId = player:getStorageValue(Storage.SvargrondArena.Pit)
	if pitId < 1 or pitId > 10 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You cannot enter without Halvar\'s permission.')
		player:teleportTo(fromPosition)
		return true
	end

	local arenaId = player:getStorageValue(Storage.SvargrondArena.Arena)
	if not(PITS[pitId] and ARENA[arenaId]) then
		player:teleportTo(fromPosition)
		return true
	end

	local occupant = SvargrondArena.getPitOccupant(pitId, player)
	if occupant then
		player:sendTextMessage(MESSAGE_INFO_DESCR, occupant:getName() .. ' is currently in the next arena pit. Please wait until ' .. (occupant:getSex() == 0 and 's' or '') .. 'he is done fighting.')
		player:teleportTo(fromPosition)
		return true
	end

	SvargrondArena.resetPit(pitId)
	SvargrondArena.scheduleKickPlayer(cid, pitId)
	Game.createMonster(ARENA[arenaId].creatures[pitId], PITS[pitId].summon, true, true)

	player:teleportTo(PITS[pitId].center)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:say('FIGHT!', TALKTYPE_MONSTER_SAY)
	return true
end