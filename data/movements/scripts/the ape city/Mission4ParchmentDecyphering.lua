function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.TheApeCity.Questline) == 8
			and player:getStorageValue(Storage.TheApeCity.ParchmentDecyphering) ~= 1 then
		player:setStorageValue(Storage.TheApeCity.ParchmentDecyphering, 1)
	end

	player:say("!-! -O- I_I (/( --I Morgathla", TALKTYPE_MONSTER_SAY)
	return true
end
