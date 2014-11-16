function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if itemEx.actionid == 4638 then
		if player:getStorageValue(Storage.GravediggerOfDrefia.Mission28) == 1 and player:getStorageValue(Storage.GravediggerOfDrefia.Mission29) < 1 then
			player:setStorageValue(Storage.GravediggerOfDrefia.Mission29, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The ashes swirl with a life of their own, mixing with the sparks of the altar.')
			Item(item.uid):remove(1)
		end
	end
	return true
end